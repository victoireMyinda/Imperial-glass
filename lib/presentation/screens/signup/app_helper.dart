import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';

class AppHelper {
  static Future<File?> cropImage(File? imageFile) async {
    var _croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      // maxWidth: 1080,
      //   maxHeight: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 3.0, ratioY: 3.0),
      // aspectRatioPresets: Platform.isAndroid
      //     ? [
      //         CropAspectRatioPreset.square,
      //         // CropAspectRatioPreset.ratio3x2,
      //         // CropAspectRatioPreset.original,
      //         // CropAspectRatioPreset.ratio4x3,
      //         // CropAspectRatioPreset.ratio16x9
      //         //       CropAspectRatioPreset.ratio3x2,
      //         // CropAspectRatioPreset.ratio4x3,
      //         // CropAspectRatioPreset.ratio5x3,
      //         // CropAspectRatioPreset.ratio5x4,
      //         // CropAspectRatioPreset.ratio7x5,
      //         // CropAspectRatioPreset.ratio16x9
      //       ]
      //     : [
      //         CropAspectRatioPreset.original,
      //         CropAspectRatioPreset.square,
      //         CropAspectRatioPreset.ratio3x2,
      //         CropAspectRatioPreset.ratio4x3,
      //         CropAspectRatioPreset.ratio5x3,
      //         CropAspectRatioPreset.ratio5x4,
      //         CropAspectRatioPreset.ratio7x5,
      //         CropAspectRatioPreset.ratio16x9
      //       ],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: "Modifier l'image",
          toolbarColor: Colors.blueAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          hideBottomControls: false,
          lockAspectRatio: true),
      iosUiSettings: const IOSUiSettings(
          title: "Modifier l'image",
          // toolbarColor: Colors.blueAccent,
          // toolbarWidgetColor: Colors.white,
          // initAspectRatio: CropAspectRatioPreset.original,
          // hideBottomControls: false,
          aspectRatioPickerButtonHidden: true),
    );

    return _croppedFile;
  }

  // static Future<File> compress({
  //   required File image,
  //   int quality = 20,
  //   int percentage = 60,
  // }) async {
  //   var path = await FlutterNativeImage.compressImage(image.absolute.path,
  //       quality: quality, percentage: percentage);
  //   return path;
  // }
}
