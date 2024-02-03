// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/theme.dart';

class TransAcademiaNameInput extends StatefulWidget {
  const TransAcademiaNameInput(
      {super.key,
      this.field,
      this.fieldValue,
      this.controller,
      this.color,
      this.hintText,
      this.validator,
      this.label,
      this.isError,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? field;
  final String? fieldValue;
  final String? isError;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaNameInputState createState() => _TransAcademiaNameInputState();
}

class _TransAcademiaNameInputState extends State<TransAcademiaNameInput> {
  // final GlobalKey<ScaffoldState> _fieldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.fieldValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
            key: widget.key,
            keyboardType: widget.field == "quantiteProduit"
                ? TextInputType.number
                : TextInputType.text,
            onChanged: (String value) {
              BlocProvider.of<SignupCubit>(context).updateField(context,
                  data: value.toString(),
                  field: widget.field.toString() + "Error");
              BlocProvider.of<SignupCubit>(context).updateField(context,
                  data: value.toString(), field: widget.field.toString());
            },
            controller: _controller,
            decoration: InputDecoration(
              label: Text(
                widget.label.toString(),
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              hintText: widget.hintText,
              // hintStyle: const TextStyle(color: Colors.black54),
              border: myinputborder(), //normal border
              enabledBorder:
                  myfocusborder(context, widget.isError), //enabled border
              focusedBorder: myfocusborder(context, widget.isError),
              //focused border
              // set more border style like disabledBorder
            ));
      },
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder(BuildContext context, String? isError) {
  return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        // color: Colors.black26,
        color: isError == "error"
            ? Color.fromARGB(255, 196, 16, 3)
            : Theme.of(context).backgroundColor,
        width: isError == "error" ? 2 : 1,
      ));
}
