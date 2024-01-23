import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardNotification extends StatefulWidget {
  String? icon;
  String? title;
  CardNotification({super.key, this.icon, this.title});

  @override
  State<CardNotification> createState() => _CardNotificationState();
}

class _CardNotificationState extends State<CardNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
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
                children: const [
                  Icon(
                    Icons
                        .person_rounded, // Use the appropriate icon from the Material library
                    size: 25.0,
                      color: Color.fromARGB(255, 244, 131, 169),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Victoire Myinda",
                    style: TextStyle(
                       fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
              const Text(
                "11/01/2022",
                style: TextStyle( fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Quantité obtenue",
                style: TextStyle(
                   fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "20 Litres",
                style: TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.w400
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Quantité Vendue",
                style: TextStyle(
                   fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "10 Litres",
                style: TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.w400
                ),
              )
            ],
          ),
         const  SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Total en chiffre",
                style: TextStyle(
                   fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "80.000 fc",
                style: TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.w400
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
}
