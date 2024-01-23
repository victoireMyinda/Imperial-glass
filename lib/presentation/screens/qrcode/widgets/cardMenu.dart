import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardMenu extends StatefulWidget {
  String? icon;
  String? title;
  CardMenu({super.key, this.icon, this.title });

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.icon.toString(), width: 30,),
          const SizedBox(height: 10,),
          Text(widget.title.toString())
        ],
      ),
    );
  }
}
