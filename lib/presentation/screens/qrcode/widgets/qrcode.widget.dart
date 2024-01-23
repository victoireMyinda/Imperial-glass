// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:icecream_service/theme.dart';

// // class QrCodeWidget extends StatefulWidget {
// //   final String value;
// //   const QrCodeWidget({super.key, required this.value});

// //   @override
// //   State<QrCodeWidget> createState() => _QrCodeWidgetState();
// // }

// // class _QrCodeWidgetState extends State<QrCodeWidget> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //         // color: Colors.grey.withOpacity(0.1),
// //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
// //         width: MediaQuery.of(context).size.width,
// //         child: Column(
// //           // mainAxisAlignment: MainAxisAlignment.center,
// //           // crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             const Text(
// //               "Mon QrCode",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w400,
// //                 fontSize: 18,
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 100.0,
// //             ),
// //             Container(
// //               alignment: Alignment.center,
// //               padding: const EdgeInsets.all(30.0),
// //               width: MediaQuery.of(context).size.width,
// //               height: 400.0,
// //               decoration: BoxDecoration(
// //                   // color: Colors.white,
// //                   color: Theme.of(context).accentColor,
// //                   borderRadius: BorderRadius.circular(20.0)),
// //               child: QrImage(
// //                 data: widget.value,
// //                 // data: "12345bh",
// //                 version: QrVersions.auto,
// //                 size: 250.0,
// //                 foregroundColor: primaryColor.withOpacity(0.8),
// //                 embeddedImage: AdaptiveTheme.of(context).mode.name == "dark"
// //                     ? const AssetImage('assets/images/logo-kelasi.png')
// //                     : const AssetImage('assets/images/qrlogo-trans.png'),
// //                 embeddedImageStyle: QrEmbeddedImageStyle(
// //                   size: const Size(35, 35),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ));
// //   }
// // }

// class QRCode extends StatelessWidget {
//   const QRCode({
//     Key? key,
//     this.width,
//     this.height,
//     this.qrSize,
//     required this.qrData,
//     this.gapLess,
//     this.qrVersion,
//     this.qrPadding,
//     this.qrBorderRadius,
//     this.semanticsLabel,
//     this.qrBackgroundColor,
//     this.qrForegroundColor,
//   }) : super(key: key);

//   // Required by FF (NOT USED IN WIDGET)
//   final double? width;
//   final double? height;
//   // The (square) size of the image
//   final double? qrSize;
//   // Text data to the encoded
//   final String qrData;
//   // Adds an extra pixel in size to prevent gaps (default is true).
//   final bool? gapLess;
//   // `QrVersions.auto` or a value between 1 and 40.
//   // See http://www.qrcode.com/en/about/version.html for limitations and details.
//   final int? qrVersion;
//   // Padding on all sides
//   final double? qrPadding;
//   // Circular border radius beside the QR code
//   final double? qrBorderRadius;
//   // Will be used by screen readers to describe the content of the QR code.
//   final String? semanticsLabel;
//   // 	The background color (default is transparent).
//   final Color? qrBackgroundColor;
//   //	The foreground color (default is black).
//   final Color? qrForegroundColor;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(qrBorderRadius ?? 0),
//       child: QrImage(
//         size: qrSize,
//         data: qrData,
//         gapless: gapLess ?? true,
//         version: qrVersion ?? QrVersions.auto,
//         padding: EdgeInsets.all(qrPadding ?? 10),
//         semanticsLabel: semanticsLabel ?? '',
//         backgroundColor: qrBackgroundColor ?? Colors.transparent,
//         // foregroundColor: qrForegroundColor ?? Colors.black,

//                         foregroundColor: primaryColor.withOpacity(0.8),
//                 embeddedImage: AdaptiveTheme.of(context).mode.name == "dark"
//                     ? const AssetImage('assets/images/logo-kelasi.png')
//                     : const AssetImage('assets/images/qrlogo-trans.png'),
//                 embeddedImageStyle: QrEmbeddedImageStyle(
//                   size: const Size(50, 50),
//                 ),
//       ),
//     );
//   }
// }
