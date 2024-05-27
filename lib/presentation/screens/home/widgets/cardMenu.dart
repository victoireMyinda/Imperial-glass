// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/theme.dart';

class CardMenu extends StatefulWidget {
  String? icon;
  String? title;
  bool? active, isNotShadow;
  CardMenu(
      {super.key,
      this.icon,
      this.title,
      required this.active,
      this.isNotShadow});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.icon.toString(),
            color: Color.fromARGB(255, 131, 105, 95),
            height: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.title.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  // Widget _buildActiveCard() {
  //   return Container(
  //     width: 100,
  //     padding: const EdgeInsets.all(5),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20.0),
  //       color:  Colors.white,
  //       border: Border.all(
  //           width: 1,
  //           color:  Colors.white
  //            ),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         SvgPicture.asset(
  //           widget.icon.toString(),
  //           width: 60,
  //           color: kelasiColor,
  //         ),
  //         const SizedBox(
  //           height: 30,
  //         ),
  //         Text(
  //           widget.title.toString(),
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(
  //             fontSize: 12,
  //             color: Colors.black,
  //             // fontWeight: FontWeight.bold,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildInactiveCard() {
  //   return Container(
  //     height: 120.0,
  //     width: 120.0,
  //     padding: const EdgeInsets.all(5),
  //     decoration: BoxDecoration(
  //       color: Colors.black26,
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         SvgPicture.asset(
  //           widget.icon.toString(),
  //           width: 40,
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Text(
  //           widget.title.toString(),
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(
  //             fontSize: 10,
  //             fontWeight: FontWeight.w300,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
