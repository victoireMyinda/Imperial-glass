import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AkilimaliSimplePhoneNumberField extends StatefulWidget {
  AkilimaliSimplePhoneNumberField({this.controller, this.color, this.hintText, this.validator});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  @override
  _AkilimaliSimplePhoneNumberFieldState createState() => _AkilimaliSimplePhoneNumberFieldState();
}

class _AkilimaliSimplePhoneNumberFieldState extends State<AkilimaliSimplePhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  widget.controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color ?? Colors.grey)
        ),
        errorBorder : OutlineInputBorder(
          borderSide: BorderSide(color: widget.color ?? Colors.red)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: widget.color ?? Colors.red)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color ?? Colors.red)
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.montserrat(
                  color: widget.color ?? Colors.grey,
        ),
        focusColor: widget.color ?? Colors.red,
        errorText: widget.validator,
      ),
      style: TextStyle(
        fontSize: 16,
        color: widget.color
      ),
    );
  }
}