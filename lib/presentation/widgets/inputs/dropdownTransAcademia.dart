// ignore_for_file: file_names
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';

class TransAcademiaDropdown extends StatefulWidget {
  const TransAcademiaDropdown(
      {super.key,
      this.controller,
      this.value,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.items,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? value;
  final String? items;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaDropdownState createState() => _TransAcademiaDropdownState();
}

class _TransAcademiaDropdownState extends State<TransAcademiaDropdown> {
  String? labelForDropdown;

  @override
  void initState() {
    super.initState();

    if (widget.value == "universite") {
      labelForDropdown = "abreviation";
    } else if (widget.value == "departement") {
      labelForDropdown = "Departement";
    } else if (widget.value == "promotion") {
      labelForDropdown = "Promotion";
    } else if (widget.value == "abonnement") {
      labelForDropdown = "Type";
    } else if (widget.value == "province") {
      labelForDropdown = "province";
    }  else if (widget.value == "ville") {
      labelForDropdown = "labele";
    } else if (widget.value == "commune") {
      labelForDropdown = "labele";
    } else if (widget.value == "level") {
      labelForDropdown = "label";
    } else {
      labelForDropdown = "libele";
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    // borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
                validator: (value) =>
                    value == null ? "Selectionner l'université" : null,
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                    ? Colors.black
                    : Colors.white,
                value: state.field![widget.value] == ""
                    ? null
                    : state.field![widget.value],
                onChanged: (newValue) {
                  // selectedValue = newValue!.toString();
                  if (widget.value == "universite") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "faculte", data: "");
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "departement", data: "");
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "promotion", data: "");
                  }
                  if (widget.value == "faculte") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "departement", data: "");
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "promotion", data: "");
                  }
                  if (widget.value == "departement") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "promotion", data: "");
                  }
                  if (widget.value == "province") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "ville", data: "");
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "commune", data: "");
                  } if (widget.value == "ville") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "commune", data: "");
                  }
                  if (widget.value == "section") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "option", data: "");
                  }
                  BlocProvider.of<SignupCubit>(context).updateField(context,
                      field: widget.value.toString(),
                      data: newValue.toString());

                  // getDataFacultes();
                },
                // items: dropdownItems
                items: state.field![widget.items]
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem(
                    value: widget.value == "option"
                        ? item['Id_option'].toString()
                        : item['id'].toString(),
                    child: SizedBox(
                      width: 200.0,
                      child: Text(
                        item![labelForDropdown].toString(),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("UNIKIN"), value: "Unikin"),
    DropdownMenuItem(child: Text("ISTA"), value: "ISTA"),
    DropdownMenuItem(child: Text("ISC"), value: "ISC"),
    DropdownMenuItem(child: Text("ABA"), value: "ABA"),
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
