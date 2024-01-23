// ignore_for_file: must_be_immutable

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/theme.dart';

class QrCodeScreenV2 extends StatefulWidget {
  bool backNavigation;

  QrCodeScreenV2({Key? key, required this.backNavigation}) : super(key: key);

  @override
  State<QrCodeScreenV2> createState() => _QrCodeScreenV2State();
}

class _QrCodeScreenV2State extends State<QrCodeScreenV2> {
  String? codeStudent = '';
  var test;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    test = codeStudent;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: QrPainter(
                data: codeStudent.toString(),
                options: QrOptions(
                  shapes: const QrShapes(
                    darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                    frame: QrFrameShapeRoundCorners(cornerFraction: .50),
                    ball: QrBallShapeRoundCorners(cornerFraction: .50),
                  ),
                  colors: QrColors(
                    background: QrColorSolid(
                      AdaptiveTheme.of(context).mode.name == "dark"
                          ? Colors.black
                          : Colors.white,
                    ),
                    dark: QrColorLinearGradient(
                      colors: [
                        const Color(0xff129BFF),
                        kelasiColor,
                      ],
                      orientation: GradientOrientation.leftDiagonal,
                    ),
                  ),
                ),
              ),
              size: const Size(350, 350),
            ),
            // Image.asset(
            //   AdaptiveTheme.of(context).mode.name != "dark"
            //       ? "assets/images/logo-kelasi.png"
            //       : "assets/images/logo-kelasi.png",
            //   width: 40, // Ajustez la largeur selon vos besoins
            //   height: 40, // Ajustez la hauteur selon vos besoins
            // ),
          ],
        ),
      ),
    );
  }
}
