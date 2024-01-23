import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/data/models/abonnement.dart';
import 'package:icecream_service/presentation/screens/home/home_screen.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step2.dart';
import 'package:icecream_service/presentation/screens/signup/signup.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogVerif.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
// ignore: unused_import
import 'package:icecream_service/locale/all_translations.dart';
import 'package:icecream_service/presentation/widgets/inputs/dateField.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/sizeconfig.dart';
import 'package:icecream_service/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SignupStep1 extends StatefulWidget {
  const SignupStep1({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupStep1State createState() => _SignupStep1State();
}

class _SignupStep1State extends State<SignupStep1> {
  TextEditingController nomController = TextEditingController();
  TextEditingController postnomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController universiteController = TextEditingController();
  TextEditingController faculteController = TextEditingController();
  TextEditingController departementController = TextEditingController();
  TextEditingController promotionController = TextEditingController();
  TextEditingController lieuNaissanceController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;
  bool checked = false;
  late List<Abonnement> allAbonnements;
  String stateInfoUrl = 'https://api.trans-academia.cd/';
  final Uri _url = Uri.parse('https://trans-academia.cd/privacy.html');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).initForm();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "filePath", data: "");
  }

  Future<void> launchUrlSite() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        BlocProvider.of<SignupCubit>(context).initForm();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          Text(
                            "Compléter votre profil étudiant",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          // Text(
                          //   "Completer votre profil",
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ],
                      ),
                    ),


                    const SizedBox(
                      height: 20.0,
                    ),

                    const TransAcademiaDropdown(
                      items: "universiteData",
                      value: "universite",
                      label: "Choisir Etablissement",
                      hintText: "choisir Université",
                    ),

                    const TransAcademiaDropdown(
                      items: "faculteData",
                      value: "faculte",
                      label: "Choisir la faculté / Section",
                      hintText: "choisir la faculté",
                    ),

                    const TransAcademiaDropdown(
                      items: "departementData",
                      value: "departement",
                      label: "Choisir le département / Fillière",
                      hintText: "choisir le département",
                    ),
                    const TransAcademiaDropdown(
                      items: "promotionData",
                      value: "promotion",
                      label: "Choisir la promotion",
                      hintText: "choisir la promotion",
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaNameInput(
                                controller: emailController,
                                hintText: "Lieu de naissance",
                                color: Colors.white,
                                label: "Lieu de naissance",
                                field: "lieuNaissance",
                                fieldValue: state.field!["lieuNaissance"],
                              ),
                            ));
                      },
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaDatePicker(
                                  controller: dateNaissanceController,
                                  hintText: "Date de naissance",
                                  color: Colors.white,
                                  label: "Date de naissance",
                                  field: "dateNaissance",
                                  fieldValue: state.field!["dateNaissance"]),
                            ));
                      },
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaNameInput(
                                controller: lieuNaissanceController,
                                hintText: "Votre adresse Email",
                                color: Colors.white,
                                label: "Votre adresse Email",
                                field: "email",
                                fieldValue: state.field!["email"],
                              ),
                            ));
                      },
                    ),

                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        StepIndicatorWidget(
                          color: Colors.black26,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        StepIndicatorWidget(
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        StepIndicatorWidget(
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/routestack', (Route<dynamic> route) => false);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              height: 50.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.cyan,
                                    Colors.indigo,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Précedent",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {

                                if (state.field!["universite"] == "") {
                                  ValidationDialog.show(context,
                                      "veuillez sélectionner l'université", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["faculte"] == "") {
                                  ValidationDialog.show(
                                      context, "veuillez sélectionner la faculté",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["departement"] == "") {
                                  ValidationDialog.show(context,
                                      "veuillez sélectionner le département", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["promotion"] == "") {
                                  ValidationDialog.show(context,
                                      "veuillez sélectionner la promotion", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["lieuNaissance"] == "") {
                                  ValidationDialog.show(context,
                                      "Le lieu de naissance ne doit pas être vide",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["dateNaissance"] == "") {
                                  ValidationDialog.show(context,
                                      "la date de naissance ne doit pas être vide",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                if (!state.field!["email"].contains("@")) {
                                  ValidationDialog.show(context,
                                      "le format d'adresse mail n'est pas valide", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupStep2()),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                height: 50.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.cyan,
                                      Colors.indigo,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Suivant",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    submitError == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, top: 20.0),
                            child: Text(
                              submitError.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
