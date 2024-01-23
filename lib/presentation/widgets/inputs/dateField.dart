import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class TransAcademiaDatePicker extends StatefulWidget {
  const TransAcademiaDatePicker(
      {super.key,
      this.controller,
      this.color,
      this.hintText,
      this.validator,
      this.label,
      this.field,
      this.fieldValue,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? field;
  final String? fieldValue;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaDatePickerState createState() =>
      _TransAcademiaDatePickerState();
}

class _TransAcademiaDatePickerState extends State<TransAcademiaDatePicker> {
  TextEditingController _date = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _date.text =widget.fieldValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        // inputFormatters: [
          // LengthLimitingTextInputFormatter(widget.number),
          // FilteringTextInputFormatter.digitsOnly,
          // FilteringTextInputFormatter.singleLineFormatter,
        // ],
        controller: _date,
        onTap: () async {
        DateTime? pickeddate = await showDatePicker(
          locale: const Locale("fr", "FR"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1960),
          lastDate: DateTime(2101));
  

          if (pickeddate != null) {
            setState(() {
              _date.text =  DateFormat('yyyy-MM-dd').format(pickeddate);
            });
                     
              // ignore: use_build_context_synchronously
              BlocProvider.of<SignupCubit>(context)
                  .updateField(context, data: _date.text, field: "dateNaissance");
          
          }
        },
        decoration: InputDecoration(
          
          label: Text(
            widget.label.toString(),
            style: TextStyle(
              // color: Colors.black54,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          suffixIcon: const Icon(Icons.date_range_outlined),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            // color: Colors.black54,
            color: Theme.of(context).backgroundColor,
            ),
          border: myinputborder(context), //normal border
          enabledBorder: myfocusborder(context), //enabled border
          focusedBorder: myfocusborder(context), //focused border
          // set more border style like disabledBorder
        ));
  }
}

OutlineInputBorder myinputborder(context) {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder(context) {
  return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Theme.of(context).backgroundColor,
        width: 1,
      ));
}
