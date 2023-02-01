import 'dart:async';

import 'package:b2connect_flutter/model/services/http_service.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view_model/providers/Repository/repository_pattern.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:provider/provider.dart';

import '../../model/models/userEmiratesData.dart';
import '../../model/services/util_service.dart';
import '../../model/utils/service_locator.dart';
import 'package:flutter/cupertino.dart';

import 'auth_provider.dart';

class ScannerProvider with ChangeNotifier {
  UserEmiratesData userEmiratesData = UserEmiratesData();

  late bool scanResult;
  bool isScanBusy = false;
  int cardType = 0;
  int cardFace = 0;
  var scale;
  var clipSize;
  var size;
  Timer? _time;
  bool resetButton = false;
  var utilService = locator<UtilService>();
  var recognisedText;
  var navigationService = locator<NavigationService>();
  late CameraController controller;
  late List<String> result;
  bool streamingStop = false;
  Repository? http = locator<HttpService>();

  setCardFace(int value) {
    this.cardFace = value;
    notifyListeners();
  }

  setStreamingStop(bool value) {
    this.streamingStop = value;
    notifyListeners();
  }

  setSize(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    notifyListeners();
  }


  setResetButton(bool value) {
    this.resetButton = value;
    notifyListeners();
  }

  setScale(var value) {
    this.scale = value;
  }

  setCardType(int value) {
    this.cardType = value;
    notifyListeners();
  }

  setScanBusy(bool value) {
    this.isScanBusy = value;
    notifyListeners();
  }

  Future<CameraController> startCamera(BuildContext context) async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
      enableAudio: false,
    );
    await controller.initialize();
    await controller.lockCaptureOrientation();

    setScale(1 /
        (controller.value.aspectRatio *
            MediaQuery.of(context).size.aspectRatio));

    return controller;
  }

  void startStreaming() {
    Future.delayed(Duration(seconds: 3), () async {
      _startTimer();
      this.setCardFace(1);
      this.setCardType(1);
      setStreamingStop(false);
      await controller.startImageStream((image) {
        if (this.isScanBusy) {
          stopTimer();
          return;
        } else {
          this.checkCardFaceAndType(image);
        }
      });
    });
  }

  void _startTimer() {
    _time = Timer.periodic(Duration(seconds: 10), (Timer t) {
      this.setResetButton(true);
      this.setCardFace(3);
      this.setCardType(3);
      streamingStop == false?
      controller.stopImageStream().then((value) => setStreamingStop(true)) : setStreamingStop(false);
      t.cancel();
    });
  }

  void stopTimer() {
    if (_time != null) _time!.cancel();
  }

  onBackPressed(BuildContext context){

    streamingStop == false?
    controller.stopImageStream().then((value) => setStreamingStop(true)) : setStreamingStop(false);
  }

  Future<dynamic> sendEmiratesData(BuildContext context) async {
    var emiratesId = userEmiratesData.emiratesId;
    var emiratesExpiry = userEmiratesData.emiratesExpiry;
    final expiryDate;
    final expiryDateResult = emiratesExpiry!.split('/');
    final emiratesResult = emiratesId!.split('-');

    if (expiryDateResult.length == 3 && emiratesResult.length == 4) {
      expiryDate = await convertDateToTimeStamp(expiryDateResult);
      try {
        var response = await http!.sendEmiratesData(
            emiratesId,
            expiryDate!);

        if (response.statusCode == 200) {
          await Provider.of<AuthProvider>(context, listen: false)
              .callUserInfo(context);
          var count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 3;
          });
          return EasyLoading.showSuccess('Verified Successfully');
        } else {
          EasyLoading.showError('Please ReCheck Your Emirates Id or Expiry');
          return null;
        }
      } on PlatformException catch (e) {
        EasyLoading.dismiss();
        print(e);
      }
      catch(e){
        EasyLoading.dismiss();
        print(e);
      }
    } else {
      return EasyLoading.showError('Expiry Date or Emirates Id is not valid');
    }

  }

  Future<void> scanCard(String? text) async {
    recognisedText = text;

    result = text!.split('\n');
    RegExp dateExp = new RegExp('\\d{2}/\\d{2}/\\d{4}');
    RegExp emirateIdExp = new RegExp(r'^784-[0-9]{4}-[0-9]{7}-[0-9]{1}$');

    print(result);

    if (cardType == 2 && cardFace == 2) {
      final birthDateIndex =
      result.indexWhere((element) => element.contains('Date of Birth'));

      final List<String> dateOfBirth =
      getSubString("Date of Birth", result[birthDateIndex]).split(" ");
      dateOfBirth[0].contains(dateExp)
          ? this.userEmiratesData.emiratesBirthday =
          dateExp.firstMatch(dateOfBirth[0])?.group(0)
          : this.userEmiratesData.emiratesBirthday = 'Not Valid';

      final expiryDateIndex =
      result.indexWhere((element) => element.contains('Expiry'));
      result[expiryDateIndex + 1].contains(dateExp)
          ? this.userEmiratesData.emiratesExpiry =
          dateExp.firstMatch(result[expiryDateIndex + 1])?.group(0)
          : result[expiryDateIndex + 2].contains(dateExp)
          ? this.userEmiratesData.emiratesExpiry =
          dateExp.firstMatch(result[expiryDateIndex + 2])?.group(0)
          : this.userEmiratesData.emiratesExpiry = 'Not Valid';
      final genderIndex =
      result.indexWhere((element) => element.contains('Sex'));
      result[genderIndex].contains('F')
          ? this.userEmiratesData.emiratesGender = 'Female'
          : this.userEmiratesData.emiratesGender = 'Male';
      this.setCardFace(1);
      this.setCardType(1);
      navigationService.navigateTo(EidDetailScreenRoute);
    } else if (cardType == 2 && cardFace == 1) {
      final idIndex =
      result.indexWhere((element) => element.contains('ID Number'));
      result[idIndex + 1].contains(emirateIdExp)
          ? this.userEmiratesData.emiratesId =
          emirateIdExp.firstMatch(result[idIndex + 1])?.group(0)
          : this.userEmiratesData.emiratesId = 'Not Valid';

      final nameIndex =
      result.indexWhere((element) => element.contains('Name'));
      this.userEmiratesData.emiratesName =
          getSubString("Name", result[nameIndex]);

      final nationalityIndex =
      result.indexWhere((element) => element.contains('Nationality'));
      this.userEmiratesData.emiratesNationality =
          getSubString("Nationality", result[nationalityIndex]);
      utilService.showToast('Kindly Flip Your Card');
      this.setScanBusy(false);
      this.setCardFace(2);
      this.setCardType(2);
    } else if (cardType == 1 && cardFace == 2) {
      final idIndex =
      result.indexWhere((element) => element.contains('ID Number'));
      result[idIndex + 1].contains(emirateIdExp)
          ? this.userEmiratesData.emiratesId =
          emirateIdExp.firstMatch(result[idIndex + 1])?.group(0)
          : this.userEmiratesData.emiratesId = 'Not Valid';

      final nameIndex =
      result.indexWhere((element) => element.contains('Name'));
      this.userEmiratesData.emiratesName =
          getSubString("Name", result[nameIndex]);

      final nationalityIndex =
      result.indexWhere((element) => element.contains('Nationality'));
      this.userEmiratesData.emiratesNationality =
          getSubString("Nationality", result[nationalityIndex]);

      final birthDateIndex =
      result.indexWhere((element) => element.contains('Date of Birth'));
      result[birthDateIndex + 1].contains(dateExp)
          ? this.userEmiratesData.emiratesBirthday =
          dateExp.firstMatch(result[birthDateIndex + 1])?.group(0)
          : result[birthDateIndex + 2].contains(dateExp)
          ? this.userEmiratesData.emiratesBirthday =
          dateExp.firstMatch(result[birthDateIndex + 2])?.group(0)
          : this.userEmiratesData.emiratesBirthday = 'Not Valid';

      final expiryDateIndex =
      result.indexWhere((element) => element.contains('Expiry Date'));
      result[expiryDateIndex + 1].contains(dateExp)
          ? this.userEmiratesData.emiratesExpiry =
          dateExp.firstMatch(result[expiryDateIndex + 1])?.group(0)
          : result[expiryDateIndex + 2].contains(dateExp)
          ? this.userEmiratesData.emiratesExpiry =
          dateExp.firstMatch(result[expiryDateIndex + 2])?.group(0)
          : this.userEmiratesData.emiratesExpiry = 'Not Valid';

      final genderIndex =
      result.indexWhere((element) => element.contains('Sex'));
      result[genderIndex].contains('F')
          ? this.userEmiratesData.emiratesGender = 'Female'
          : result[genderIndex + 1].contains('F')
          ? this.userEmiratesData.emiratesGender = 'Female'
          : this.userEmiratesData.emiratesGender = 'Male';
      this.setCardFace(1);
      this.setCardType(1);
      navigationService.navigateTo(EidDetailScreenRoute);
    }
  }

  String getSubString(title, value) {
    return value.substring((title.length + 1));
  }

  Future<int> convertDateToTimeStamp(List<String> date) async {
    final DateTime date2 =
    DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
    final timestamp = date2.millisecondsSinceEpoch;
    final timeStamp = timestamp / 1000;
    return timeStamp.toInt();
  }

  Future<String> scanText(CameraImage image) async {
    final GoogleVisionImageMetadata metadata = GoogleVisionImageMetadata(
        rawFormat: image.format.raw,
        size: Size(image.width.toDouble(), image.height.toDouble()),
        planeData: image.planes
            .map((currentPlane) => GoogleVisionImagePlaneMetadata(
            bytesPerRow: currentPlane.bytesPerRow,
            height: currentPlane.height,
            width: currentPlane.width))
            .toList(),
        rotation: ImageRotation.rotation90);

    final GoogleVisionImage visionImage =
    GoogleVisionImage.fromBytes(image.planes[0].bytes, metadata);

    final TextRecognizer textRecognizer =
    GoogleVision.instance.textRecognizer();
    final VisionText visionText =
    await textRecognizer.processImage(visionImage);
    textRecognizer.close();

    return visionText.text!;
  }

  void checkCardFaceAndType(CameraImage image) {
    this.setScanBusy(true);
    _startTimer();
    if (this.cardFace == 2 && this.cardType == 2) {
      scanText(image).then((visionText) {
        if (
        visionText.contains('Expiry')) {
          this.scanCard(visionText);
        } else {
          print("non");
          this.setScanBusy(false);
        }
      });
    } else if (this.cardFace == 1 && this.cardType == 1) {
      scanText(image).then((visionText) {
        if (visionText.contains('UNITED ARAB EMIRATES') &&
            visionText.contains('Name') &&
            visionText.contains('Date of Birth') &&
            visionText.contains('Nationality') &&
            visionText.contains('Expiry Date') &&
            visionText.contains('ID Number')) {
          this.setCardFace(2);
          this.setCardType(1);
          this.scanCard(visionText);
        } else if (visionText.contains('United Arab Emirates') &&
            visionText.contains('Name') &&
            visionText.contains('Nationality') &&
            visionText.contains('ID Number')) {
          this.setCardFace(1);
          this.setCardType(2);
          this.scanCard(visionText);
        } else {
          print("non");
          this.setScanBusy(false);
        }
      });
    }
  }
}
