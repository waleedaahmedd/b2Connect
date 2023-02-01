import 'dart:async';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class QRCodeScreen extends StatefulWidget {
  final url;
  final title;

  const QRCodeScreen({required this.url, required this.title}) : super();

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  //GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final message =
    // ignore: lines_longer_than_80_chars
    widget.url;

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Theme.of(context).primaryColor,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Colors.black,
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          Navigator.pop(context);
        },
      ),


      body: Container(
        color: Colors.white,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('QR')!
                    ,
                    style: TextStyle(
                      fontSize: 36.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      height: 1.1.h,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'This code will be used for any B2 promo redemption and reward distribution.'
                    ,
                    style: TextStyle(
                      //fontSize: 36.sp,
                      color: Colors.grey,
                      //fontWeight: FontWeight.w500,
                      // height: 1.1.h,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: Column(
                  children: [
                    qrFutureBuilder,
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Unique QR Code References'
                      ,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        // height: 1.1.h,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
              //       .copyWith(bottom: 40),
              //   child: Text('Scan QR Code Now' ,style: TextStyle(
              //       fontSize: 30.0
              //   ),),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/images/app_icon.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}