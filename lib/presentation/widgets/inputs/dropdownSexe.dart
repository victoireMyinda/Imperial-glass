import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/theme.dart';
import'package:flutter/src/material/dropdown.dart';

class TransAcademiaDropdownSexe extends StatefulWidget {
  const TransAcademiaDropdownSexe(
      {super.key,
      this.controller,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.data,
      this.value,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? value;
  final List<dynamic>? data;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaDropdownSexeState createState() =>
      _TransAcademiaDropdownSexeState();
}

class _TransAcademiaDropdownSexeState extends State<TransAcademiaDropdownSexe> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();


    @override
  void initState() {
    super.initState();
    // if (widget.value == "universite") {
    //   labelForDropdown = "abreviation";
    // } else if (widget.value == "departement") {
    //   labelForDropdown = "Departement";
    // } else if (widget.value == "promotion") {
    //   labelForDropdown = "Promotion";
    // } else if (widget.value == "abonnement") {
    //   labelForDropdown = "Type";
    // } else {
    //   labelForDropdown = "libele";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 8.0),
              child: DropdownButtonFormField(               
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
                    label: Text(widget.label.toString()),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      // borderSide: const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
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

                    if (widget.value == "sexe") {
                        BlocProvider.of<SignupCubit>(context).updateField(context,
                        field: "sexe", data: newValue.toString());
                    } 

                  },
                  items: dropdownItems
                //   items: widget.data!.map(( item) {
                //   return DropdownMenuItem(
                //     value: item['id'].toString(),
                //     child: Text(item!['libele'].toString(), style: const TextStyle(
                //       fontSize: 14,
                //     ),),
                //   );
                // }).toList(),
                  ),
            ),
        
          ],
        ));
  }
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems =[
    DropdownMenuItem(child: Text("Homme"),value: "M"),
    DropdownMenuItem(child: Text("Femme"),value: "F"),
  ];
  return menuItems;
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

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.black26,
        width: 1,
      ));
}
