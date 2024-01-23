// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class TransAcademiaEmailField extends StatefulWidget {
  const TransAcademiaEmailField({super.key, this.controller, this.color, this.hintText, this.validator});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaEmailFieldState createState() => _TransAcademiaEmailFieldState();
}

class _TransAcademiaEmailFieldState extends State<TransAcademiaEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
    validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
      controller:  widget.controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding:const EdgeInsets.only(left: 15.0),
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
        hintStyle:GoogleFonts.montserrat(
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