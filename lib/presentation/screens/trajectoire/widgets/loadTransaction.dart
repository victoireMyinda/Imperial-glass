import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icecream_service/presentation/widgets/imageview.dart';

// ignore: must_be_immutable
class loadTransaction extends StatefulWidget {
  String? icon;
  String? title;
  String? amount;
  String? date;
  loadTransaction({super.key, this.icon, this.title});

  @override
  State<loadTransaction> createState() => _loadTransactionState();
}

class _loadTransactionState extends State<loadTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.white,
        // color: AdaptiveTheme.of(context).brightness,
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("icon"),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/menu-abonnement-trans.svg",
                    width: 20.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ImageViewerWidget(
                    url: "",
                    height: 10,
                    width: 100,
                    borderRadius: BorderRadius.circular(10.0),
                  )
                  // const Text(
                  //   "Réabonnement",
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //   ),
                  // )
                ],
              ),
              ImageViewerWidget(
                url: "",
                height: 10,
                width: 100,
                borderRadius: BorderRadius.circular(10.0),
              )
              // const Text(
              //   "11/01/2022",
              //   style: TextStyle(color: Colors.grey),
              // ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("Kwenda vuntuka "),
              ImageViewerWidget(
                url: "",
                height: 20,
                width: 100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              ImageViewerWidget(
                url: "",
                height: 20,
                width: 100,
                borderRadius: BorderRadius.circular(10.0),
              )
              // Text("1000 USD")
            ],
          ),
        ],
      ),
    );
  }
}
