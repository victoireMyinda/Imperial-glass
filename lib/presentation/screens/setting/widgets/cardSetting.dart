import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardSetting extends StatefulWidget {
  String? icon;
  String? title;
  CardSetting({super.key, this.icon, this.title});

  @override
  State<CardSetting> createState() => _CardSettingState();
}

class _CardSettingState extends State<CardSetting> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(widget.title.toString(), style: const TextStyle(
            // color: Colors.black54
            ),),
          const Icon(Icons.chevron_right,
          //  color: Colors.grey,
           ),
        ],
      ),
    );
  }
}
