import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icecream_service/theme.dart';
import'package:flutter/src/material/dropdown.dart';

class TransAcademiaDropdownPromo extends StatefulWidget {
  const TransAcademiaDropdownPromo(
      {super.key,
      this.controller,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.data,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final List<dynamic>? data;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaDropdownPromoState createState() =>
      _TransAcademiaDropdownPromoState();
}

class _TransAcademiaDropdownPromoState extends State<TransAcademiaDropdownPromo> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(              
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
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
                
                validator: (value) => value == null ? "Selectionner l'université" : null,
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark" ? Colors.black: Colors.white,
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!.toString();
                  });
                },
                // items: dropdownItems
                items: widget.data!.map(( item) {
                return DropdownMenuItem(
                  value: item['id'].toString(),
                  child: Text(item!['Promotion'].toString(), style: const TextStyle(
                    fontSize: 14,
                  ),),
                );
              }).toList(),
                ),
        
          ],
        ));
  }
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems =[
    DropdownMenuItem(child: Text("UNIKIN"),value: "Unikin"),
    DropdownMenuItem(child: Text("ISTA"),value: "ISTA"),
    DropdownMenuItem(child: Text("ISC"),value: "ISC"),
    DropdownMenuItem(child: Text("ABA"),value: "ABA"),
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
