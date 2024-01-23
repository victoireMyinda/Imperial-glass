import 'package:icecream_service/sizeconfig.dart';
import 'package:flutter/material.dart';

class StepIndicatorWidget extends StatefulWidget {
  final Color? color;
  const StepIndicatorWidget({ Key? key, this.color }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StepIndicatorWidgetState createState() => _StepIndicatorWidgetState();
}

class _StepIndicatorWidgetState extends State<StepIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width:10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.color,
      ),
    );
  }
}