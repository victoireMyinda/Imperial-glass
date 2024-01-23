import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/qrcode/qrcodeV2.dart';
import 'package:icecream_service/presentation/screens/qrcode/widgets/qrcode.widget.dart';
import 'package:icecream_service/presentation/widgets/caroussel.dart';
import 'package:icecream_service/theme.dart';

import 'widgets/cardMenu.dart';
import 'widgets/cardNumberCourse.dart';

class QrCodeScreen extends StatefulWidget {
  bool backNavigation;
  QrCodeScreen({Key? key, required this.backNavigation}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  String? codeStudent = '';
  var test;

  void initState() {
    // TODO: implement initState
    super.initState();
    getCodeStudent();
  }

  getCodeStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      codeStudent = prefs.getString('code');
    });
    print(prefs.getString('code'));
  }

  // var image = Image.asset();
  @override
  Widget build(BuildContext context) {
    test = codeStudent;
    return Scaffold(
        // backgroundColor: Colors.grey.withOpacity(0.1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // brightness: Brightness.light,
          leading: widget.backNavigation == false
              ? null
              : GestureDetector(
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
            "Mon QrCode",
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
      child: SingleChildScrollView(
        child: Container(
          // color: Colors.grey.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
       
              const SizedBox(
                height: 80.0,
              ),
              BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
                var qrValue = codeStudent;
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: 400.0,
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(20.0)),
                      child: QrCodeScreenV2(backNavigation: true,),
                  // child: QRCode(
                  //   qrSize: 320,
                  //   qrData: codeStudent.toString(),
                  //   // qrData: 'test',
                  // ),

                  // child: QrImage(
                  //   data:qrValue ,
                  //   // data: "12345bh",
                  //   version: QrVersions.auto,
                  //   size: 250.0,
                  //   foregroundColor:primaryColor.withOpacity(0.8),
                  //   embeddedImage: AdaptiveTheme.of(context).mode.name == "dark" ? AssetImage('assets/images/logo-kelasi.png') : AssetImage('assets/images/qrlogo-trans.png'),
                  //     embeddedImageStyle: QrEmbeddedImageStyle(
                  //       size: const Size(35,35),
                  //     ),
                  // ),
                );
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
