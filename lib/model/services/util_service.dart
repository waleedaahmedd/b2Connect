

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import '../../view/widgets/progress_dialog.dart';
class UtilService {
  // FirebaseService firebaseService = locator<FirebaseService>();

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black,
        fontSize: 16.0);
  }

  progressDialog(String showMsg) {
    ProgressDialog1(
      message: showMsg,
    );
  }

  /*Future<String> captureCoverImage() async {
    // firebase_storage.Reference storageReference;
    // ignore: deprecated_member_use
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    var imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return '';
    }
    _image = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    // ignore: unused_local_variable
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    // storageReference = firebase_storage.FirebaseStorage.instance
    //     .ref()
    //     .child("coverimages/$userId");
    // final firebase_storage.UploadTask uploadTask =
    //     storageReference.putFile(savedImage);
    // final firebase_storage.TaskSnapshot downloadUrl =
    //     (await uploadTask.whenComplete(() => null));
    // final String url = (await downloadUrl.ref.getDownloadURL());
    // return url;
    return '';
  }*/

  /*Future<String> capturePostImage() async {
    // firebase_storage.Reference storageReference;
    // ignore: deprecated_member_use
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    var imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return '';
    }
    _image = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    // ignore: unused_local_variable
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    // storageReference = firebase_storage.FirebaseStorage.instance
    //     .ref()
    //     .child("coverimages/$userId");
    // final firebase_storage.UploadTask uploadTask =
    //     storageReference.putFile(savedImage);
    // final firebase_storage.TaskSnapshot downloadUrl =
    //     (await uploadTask.whenComplete(() => null));
    // final String url = (await downloadUrl.ref.getDownloadURL());
    return '';
  }*/

  // Future<String> browseCoverImage(String userId) async {
  //   firebase_storage.Reference storageReference;
  //   // ignore: deprecated_member_use
  //   final picker = ImagePicker();
  //   File _image;
  //   var imageFile = await picker.getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 600,
  //   );

  //   if (imageFile == null) {
  //     return '';
  //   }
  //   _image = File(imageFile.path);
  //   final appDir = await syspaths.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(imageFile.path);
  //   final savedImage = await _image.copy('${appDir.path}/$fileName');
  //   storageReference =
  //       firebase_storage.FirebaseStorage.instance.ref().child("images/$userId");
  //   final firebase_storage.UploadTask uploadTask =
  //       storageReference.putFile(savedImage);
  //   final firebase_storage.TaskSnapshot downloadUrl =
  //       (await uploadTask.whenComplete(() => null));
  //   final String url = (await downloadUrl.ref.getDownloadURL());
  //   return url;
  // }

  // Future<String> captureImage(String userId) async {
  //   firebase_storage.Reference storageReference;
  //   // ignore: deprecated_member_use
  //   final picker = ImagePicker();
  //   File _image;
  //   var imageFile = await picker.getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 600,
  //   );

  //   if (imageFile == null) {
  //     return '';
  //   }
  //   _image = File(imageFile.path);
  //   final appDir = await syspaths.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(imageFile.path);
  //   final savedImage = await _image.copy('${appDir.path}/$fileName');
  //   storageReference =
  //       firebase_storage.FirebaseStorage.instance.ref().child("images/$userId");
  //   final firebase_storage.UploadTask uploadTask =
  //       storageReference.putFile(savedImage);
  //   final firebase_storage.TaskSnapshot downloadUrl =
  //       (await uploadTask.whenComplete(() => null));
  //   final String url = (await downloadUrl.ref.getDownloadURL());
  //   return url;
  // }

  // Future<String> browseImage(String userId) async {
  //   firebase_storage.Reference storageReference;
  //   // ignore: deprecated_member_use
  //   final picker = ImagePicker();
  //   File _image;
  //   var imageFile = await picker.getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 600,
  //   );

  //   if (imageFile == null) {
  //     return '';
  //   }
  //   _image = File(imageFile.path);
  //   final appDir = await syspaths.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(imageFile.path);
  //   final savedImage = await _image.copy('${appDir.path}/$fileName');
  //   storageReference =
  //       firebase_storage.FirebaseStorage.instance.ref().child("images/$userId");
  //   final firebase_storage.UploadTask uploadTask =
  //       storageReference.putFile(savedImage);
  //   final firebase_storage.TaskSnapshot downloadUrl =
  //       (await uploadTask.whenComplete(() => null));
  //   final String url = (await downloadUrl.ref.getDownloadURL());
  //   return url;
  // }

}
