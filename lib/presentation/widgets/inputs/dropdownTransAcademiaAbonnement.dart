// ignore_for_file: file_names, prefer_interpolation_to_compose_strings
import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:http/http.dart' as http;

class TransAcademiaDropdownAbonnement extends StatefulWidget {
  const TransAcademiaDropdownAbonnement({
    super.key,
    this.controller,
    this.value,
    this.color,
    this.label,
    this.hintText,
    this.validator,
    this.items,
    this.number,
  });
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
  _TransAcademiaDropdownAbonnementState createState() =>
      _TransAcademiaDropdownAbonnementState();
}

class _TransAcademiaDropdownAbonnementState
    extends State<TransAcademiaDropdownAbonnement> {
  String? labelForDropdown;
  bool visibleAbonnement = false;

  @override
  void initState() {
    super.initState();

    labelForDropdown = "Type";

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AbonnementCubit, AbonnementState>(
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
                    value == null ? "Selectionner l'abonnement" : null,
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                    ? Colors.black
                    : Colors.white,
                value: state.field![widget.value] == ""
                    ? null
                    : state.field![widget.value],
                onChanged: (newValue) async {
                  BlocProvider.of<AbonnementCubit>(context).updateField(context,
                      field: widget.value.toString(),
                      data: newValue.toString());

                  var dataAbonnement = [], prix_CDF, prix_USD;
                  await http.post(
                      Uri.parse(
                          "https://api.trans-academia.cd/Trans_Liste_Abonement.php"),
                      body: {
                        'App_name': "app",
                        'token': "2022"
                      }).then((response) {
                    var data = json.decode(response.body);

                    //      print(data);

                    dataAbonnement = data['donnees']
                        .where((e) => e['id'] == newValue.toString())
                        .toList();
                    prix_USD = dataAbonnement[0]['prix_USD'];
                    prix_CDF = dataAbonnement[0]['prix_CDF'];

                    BlocProvider.of<SignupCubit>(context).updateField(context,
                        field: "prixCDF", data: dataAbonnement[0]['prix_CDF']);
                    BlocProvider.of<SignupCubit>(context).updateField(context,
                        field: "prixUSD", data: dataAbonnement[0]['prix_USD']);
                    BlocProvider.of<SignupCubit>(context).updateField(context,
                        field: "abonnement", data: dataAbonnement[0]['id']);
                  });

                  // getDataFacultes();
                },
                // items: dropdownItems
                items: state.field![widget.items]
                    .where((e) => e['Type'] != 'Prelevement')
                    .where((e) => e['Type'] != state.field!["valueAbonnement"])
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem(
                    value: item['id'].toString(),
                    child: SizedBox(
                      width: 250.0,
                      child: Text(
                        item!['Duree'].toString() +
                            ' ${item!['Duree'] == "1" ? "Jour" : "Jours"} |   ' +
                            item!['prix_CDF'].toString() +
                            " FC" +
                            '   |   ' +
                            item!['prix_USD'].toString() +
                            ' \$',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
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
