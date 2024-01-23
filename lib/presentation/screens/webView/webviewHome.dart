import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'menu.dart';
import 'navigation_controls.dart';
import 'web_view_stack.dart';

class WebViewApp extends StatefulWidget {
  final String? amount;
  final String? currency;
  final String? phonenumber;
  const  WebViewApp({super.key, this.amount, this.currency, this.phonenumber});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://api.trans-academia.cd/pepele_mobile_paiement.php?amount=${widget.amount.toString()}&currency=${widget.currency}&phonenumber=${widget.phonenumber}&description=paiement'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pepele mobile'),
        actions: [
          // NavigationControls(controller: controller),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.check),
            ),
          )
          // Menu(controller: controller),
        ],
      ),
      body: WebViewStack(controller: controller),
    );
  }
}