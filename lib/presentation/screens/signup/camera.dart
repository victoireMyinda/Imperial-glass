// import 'dart:io';

// import 'package:better_open_file/better_open_file.dart';
// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as p ;

// class CameraAwesomeApp extends StatelessWidget {
//   const CameraAwesomeApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const CameraPage();
//   }
// }

// class CameraPage extends StatelessWidget {
//   const CameraPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.transparent.withOpacity(0.1),
//       // ),
//       body:CameraAwesomeBuilder.awesome(
//             saveConfig: SaveConfig.photo(
//                 pathBuilder: () => _path(CaptureMode.photo, context)),

//             // saveConfig: SaveConfig.photoAndVideo(
//             //   photoPathBuilder: () => _path(CaptureMode.photo),
//             //   videoPathBuilder: () => _path(CaptureMode.video),
//             //   initialCaptureMode: CaptureMode.photo,
//             // ),
//             // filter: AwesomeFilter.None,
//             flashMode: FlashMode.auto,
//             aspectRatio: CameraAspectRatios.ratio_16_9,
//             previewFit: CameraPreviewFit.fitWidth,
//             onMediaTap: (mediaCapture) {
//               OpenFile.open(mediaCapture.filePath);
//               print('ok ok');
//             },

//       ),
//     );
//   }

//   Future<String> _path(CaptureMode captureMode, context) async {
//     var imageUrl;
//     final Directory extDir = await getTemporaryDirectory();
//     final testDir =
//         await Directory('${extDir.path}/test').create(recursive: true);
//     final String fileExtension =
//         captureMode == CaptureMode.photo ? 'png' : 'mp4';
//     final String filePath =
//         '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
//     // BlocProvider.of<SignupCubit>(context)
//     //     .updateField(context, field: "filePath", data: filePath);

//     final compressedFile = await FlutterNativeImage.compressImage(filePath,
//         quality: 5,);
//     // return compressedFile;

//     print(compressedFile);

//   // final newPath = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(filePath)}');

//   //   final result = await FlutterImageCompress.compressAndGetFile(
//   //     filePath,
//   //     newPath,
//   //     format: CompressFormat.png,
//   //     quality: 10);
//   //   print(result);

//     // File(filePath);

//     // var request = http.MultipartRequest('POST',
//     //     Uri.parse('https://tag.trans-academia.cd/Trans-upload-image.php'));
//     // request.fields.addAll({'App_name': 'app', 'token': '2022', 'id': id});
//     // request.files.add(await http.MultipartFile.fromPath('photo', filePath));

//     // http.StreamedResponse response = await request.send();

//     // if (response.statusCode == 200) {

//     //   print(await response.stream.bytesToString());
//     //       Future.delayed(const Duration(milliseconds: 5000), () async {
//     //   // ignore: use_build_context_synchronously
//     //   Navigator.of(context).pushNamedAndRemoveUntil(
//     //       '/signupStep3', (Route<dynamic> route) => false);
//     // });
//     // return filePath;
//     // } else {
//     //   print(response.reasonPhrase);
//     //   return filePath;
//     // }

//     Future.delayed(const Duration(milliseconds: 2000), () async {
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushNamedAndRemoveUntil(
//           '/signupStep3', (Route<dynamic> route) => false);
//     });

//     return filePath;
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialogPhone.dart';
import 'app_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraPage extends StatefulWidget {
  final String id;
  final String type;
  const CameraPage({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final _picker = ImagePicker();
  File? fileImage;

  _getImageFrom({required ImageSource source}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _pickedImage = await _picker.pickImage(source: source);
    if (_pickedImage != null) {
      var image = File(_pickedImage.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      // var _compressedImage = await AppHelper.compress(image: image);
      // final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      // print('After Compress $_sizeInKbAfter kb');
      // var _croppedImage = await AppHelper.cropImage(_compressedImage);
      var _croppedImage = await AppHelper.cropImage(image);
      if (_croppedImage == null) {
        return;
      }

      if (widget.type == "update") {
        //upload image
        TransAcademiaLoadingDialog.show(context);
        var request = http.MultipartRequest('POST',
            Uri.parse('https://tag.trans-academia.cd/Trans-upload-image.php'));
        request.fields
            .addAll(
              {
               'App_name': 'app',
               'token': '2022',
               'IDgenereteCode': prefs.getString('code').toString()
               });
        request.files.add(
            await http.MultipartFile.fromPath('photo', _croppedImage.path));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          print('ok ok ok');
          TransAcademiaLoadingDialog.stop(context);
          setState(() {
            fileImage = _croppedImage;
          });

          BlocProvider.of<SignupCubit>(context).updateField(context,
              field: "filePath", data: _croppedImage.path);
        } else {
          setState(() {
            fileImage = null;
          });

          BlocProvider.of<SignupCubit>(context)
              .updateField(context, field: "filePath", data: "");
          TransAcademiaLoadingDialog.stop(context);
        }

        //fin upload

      } else {
        setState(() {
          fileImage = _croppedImage;
        });

        BlocProvider.of<SignupCubit>(context)
            .updateField(context, field: "filePath", data: _croppedImage.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey.withOpacity(0.1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // brightness: Brightness.light,
          leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AdaptiveTheme.of(context).mode.name != "dark"
                        ? Colors.black
                        : Colors.white,
                  )),
          title: Text(
            "Photo",
            style: TextStyle(
              fontSize: 14,
              color: AdaptiveTheme.of(context).mode.name != "dark"
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).bottomAppBarColor,
        ),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Lottie.asset("assets/images/photo.json", height: 280),
            ),
                const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal:10.0),
                    width: double.infinity,
                    child: const Text(
                      "Nous vous invitons à vous rendre chez notre agent Trans-academia dans votre établissement pour modifier la photo Merci. 👋🏽",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        )));
  }

  _openChangeImageBottomSheet() {
    return showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoActionSheet(
            title: const Text(
              "Changer l'image",
              textAlign: TextAlign.center,
              // style: AppTextStyles.regular(fontSize: 19),
            ),
            actions: <Widget>[
              _buildCupertinoActionSheetAction(
                icon: Icons.camera_alt,
                title: 'Prendre une photo',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.camera);
                },
              ),
              _buildCupertinoActionSheetAction(
                icon: Icons.image,
                title: 'Importer depuis la Gallery',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.gallery);
                },
              ),
              _buildCupertinoActionSheetAction(
                title: 'Annuler',
                color: Colors.red,
                voidCallback: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _buildCupertinoActionSheetAction({
    IconData? icon,
    required String title,
    required VoidCallback voidCallback,
    Color? color,
  }) {
    return CupertinoActionSheetAction(
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: color ?? const Color(0xFF2564AF),
            ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              // style: AppTextStyles.regular(
              //   fontSize: 17,
              //   color: color ?? const Color(0xFF2564AF),
              // ),
            ),
          ),
          if (icon != null)
            const SizedBox(
              width: 25,
            ),
        ],
      ),
      onPressed: voidCallback,
    );
  }
}
