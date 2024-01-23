import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/theme.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:http/http.dart' as http;

class TransAcademiaDropdownCommune extends StatefulWidget {
  const TransAcademiaDropdownCommune(
      {super.key,
      this.controller,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaDropdownCommuneState createState() =>
      _TransAcademiaDropdownCommuneState();
}

class _TransAcademiaDropdownCommuneState
    extends State<TransAcademiaDropdownCommune> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  String stateInfoUrl = 'https://api.trans-academia.cd/';



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
                  label: Text(widget.label.toString()),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    // borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
                validator: (value) =>
                    value == null ? "Selectionner la commune" : null,
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                    ? Colors.black
                    : Colors.white,
                value: state.field!["commune"] == "" ? null : state.field!["commune"],
                onChanged: (newValue) {
               
                    // selectedValue = newValue!.toString();
                    BlocProvider.of<SignupCubit>(context).updateField(context, field: "commune", data: newValue.toString());
                    
                    // getDataFacultes();

                },
                items: dropdownItems
                //   items: state.field!["universiteData"].map<DropdownMenuItem<String>>(( item) {
                //   return DropdownMenuItem(
                //     value: item['id'].toString(),
                //     child: Text(item!['abreviation'].toString(), style: const TextStyle(
                //       fontSize: 14,
                //     ),),
                //   );
                // }).toList(),
                );
          },
        ),
      ],
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Bandalungwa"), value: "Bandalungwa"),
    DropdownMenuItem(child: Text("Barumbu"), value: "Barumbu"),
    DropdownMenuItem(child: Text("Bumbu"), value: "Bumbu"),
    DropdownMenuItem(child: Text("Gombe"), value: "Gombe"),
    DropdownMenuItem(child: Text("Kalamu"), value: "Kalamu"),
    DropdownMenuItem(child: Text("Kasa-Vubu"), value: "Kasa-Vubu"),
    DropdownMenuItem(child: Text("Kimbanseke"), value: "Kimbanseke"),
    DropdownMenuItem(child: Text("Kintambo"), value: "Kintambo"),
    DropdownMenuItem(child: Text("Kisenso"), value: "Kisenso"),
    DropdownMenuItem(child: Text("Lemba"), value: "Lemba"),
    DropdownMenuItem(child: Text("Limete"), value: "Limete"),
    DropdownMenuItem(child: Text("Lingwala"), value: "Lingwala"),
    DropdownMenuItem(child: Text("Makala"), value: "Makala"),
    DropdownMenuItem(child: Text("Maluku"), value: "Maluku"),
    DropdownMenuItem(child: Text("Masina"), value: "Masina"),
    DropdownMenuItem(child: Text("Matete"), value: "Matete"),
    DropdownMenuItem(child: Text("Mont-Ngafula"), value: "Mont-Ngafula"),
    DropdownMenuItem(child: Text("Ndjili"), value: "Ndjili"),
    DropdownMenuItem(child: Text("Ngaba"), value: "Ngaba"),
    DropdownMenuItem(child: Text("Ngaliema"), value: "Ngaliema"),
    DropdownMenuItem(child: Text("Ngiri-Ngiri"), value: "Ngiri-Ngiri"),
    DropdownMenuItem(child: Text("Nsele"), value: "Nsele"),
    DropdownMenuItem(child: Text("Selembao"), value: "Selembao"),
  ];
  return menuItems;
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black26,
        width: 1,
      ));
}
