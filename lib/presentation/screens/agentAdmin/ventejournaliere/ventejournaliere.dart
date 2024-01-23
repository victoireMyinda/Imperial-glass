import 'package:flutter/material.dart';
import '../../../widgets/appbarkelasi.dart';
import 'widgets/cardNotification.dart';

// ignore: must_be_immutable
class VenteJournaliereScreen extends StatefulWidget {
  final bool? backNavigation;
  const VenteJournaliereScreen({Key? key, this.backNavigation}) : super(key: key);

  @override
  State<VenteJournaliereScreen> createState() => _VenteJournaliereScreenState();
}

class _VenteJournaliereScreenState extends State<VenteJournaliereScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(0.1),
          appBar: AppBarKelasi(
            title: "Ventes journalieres",
            leftIcon: "assets/icons/rowback-icon.svg",
            visibleAvatar: false,
            sizeleftIcon: 12,
            backgroundColor: const Color.fromARGB(255, 244, 131, 169),
            color: Colors.white,
            onTapFunction: () => Navigator.of(context).pop(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.grey.withOpacity(0.1),
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text("Notification"),
                    CardNotification(),
                    CardNotification(),
                    CardNotification(),
                    CardNotification(),
                    CardNotification(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                            color: Color.fromARGB(255, 244, 131, 169),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Chiffre total",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "300.000 fc",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
