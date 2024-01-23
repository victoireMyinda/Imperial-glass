// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step2.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialogPhone.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownPayment.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:icecream_service/routestack.dart';
import 'package:icecream_service/theme.dart';
import 'package:http/http.dart' as http;

class TransAcademiaDialogVerif {
  static show(BuildContext context, String? text, data, Function? onClose) {
    showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          RegExp checkLengthNumber = RegExp("\d{9}[0-9]");
          // int selectedIndex = -1;
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: InkWell(
                  // onTap: () => Navigator.of(context).pop(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 500.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 7.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AdaptiveTheme.of(context).mode.name == "dark"
                              ? Colors.black
                              : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: const Icon(Icons.close))),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text("Veuillez cliquez sur votre identité"),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        BlocProvider.of<SignupCubit>(context)
                                            .updateField(context,
                                                field: "id",
                                                data: data[index]['id']
                                                    .toString());

                                        BlocProvider.of<SignupCubit>(context)
                                            .updateField(context,
                                                field: "selectedIndex",
                                                data: index.toString());

                                        BlocProvider.of<SignupCubit>(context)
                                            .updateField(context,
                                                field: "status",
                                                data: data[index]['status']
                                                    .toString());
                                      },
                                      child:
                                          BlocBuilder<SignupCubit, SignupState>(
                                        builder: (context, state) {
                                          return Container(
                                            padding: const EdgeInsets.all(10.0),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            // height: 100.0,
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_constructors
                                              gradient: state.field![
                                                          "selectedIndex"] ==
                                                      index.toString()
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Colors.cyan,
                                                        Colors.indigo,
                                                      ],
                                                    )
                                                  : null,
                                              border: Border.all(
                                                  width: 1,
                                                  // color:
                                                  //     AdaptiveTheme.of(context)
                                                  //                 .mode
                                                  //                 .name ==
                                                  //             "dark"
                                                  //         ? Colors.white
                                                  //         : Colors.black),
                                                  color: state.field![
                                                              "selectedIndex"] ==
                                                          index.toString()
                                                      ? Colors.white
                                                      : (AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .name ==
                                                              "dark"
                                                          ? Colors.white
                                                          : Colors.black)),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Nom : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    Text(
                                                      data[index]['nom']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Postnom : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    Text(
                                                      data[index]['postnom']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Prénom : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    Text(
                                                      data[index]['prenom']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Etablissement : ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: state.field![
                                                                        "selectedIndex"] ==
                                                                    index
                                                                        .toString()
                                                                ? Colors.white
                                                                : null)),
                                                    Text(
                                                      data[index]['abreviation']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Faculté | Section : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    Text(
                                                      data[index][
                                                              'libele_faculte']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                          
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Département | Filliėre :',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    Text(
                                                      data[index][
                                                              'libele_departement']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Promotion : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    Text(
                                                      data[index][
                                                              'libele_promotion']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: state.field![
                                                                      "selectedIndex"] ==
                                                                  index
                                                                      .toString()
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    if (state.field!["selectedIndex"] == "") {
                                      ValidationDialog.show(context,
                                          "veuillez sélectionner votre Identité ",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    if (state.field!["status"] == "PENDING" ||
                                        state.field!["status"] == "") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupStep2(
                                                  isStudentPage: true,
                                                )),
                                      );
                                    } else {
                                      TransAcademiaDialogError.show(
                                          context,
                                          "Vous avez déjà un compte veuillez vous connectez",
                                          "paiement");
                                      Future.delayed(
                                          const Duration(milliseconds: 4000),
                                          () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/login',
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                    }
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child:
                                        ButtonTransAcademia(title: "Suivant"),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
