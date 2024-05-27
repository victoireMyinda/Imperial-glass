// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/sizeconfig.dart';
import 'package:icecream_service/presentation/widgets/inputs/passwordTextField.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;
  String stateInfoUrl = 'https://api.trans-academia.cd/';
  var androidState;
  var iosState;
  var dataAbonnement = [], prixCDF, prixUSD;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
    print(AdaptiveTheme.of(context).mode.name);
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "password", data: "");
    // checkVersion();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ToastContext().init(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            // color: Colors.white
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                MyColors.myWhite
                // Color(0xff0E0A70)
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: Platform.isIOS == true ? 30 : 30,
                    ),

                    // const SizedBox(
                    //   height: 80.0,
                    // ),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage(
                        AdaptiveTheme.of(context).mode.name != "dark"
                            ? "assets/images/icon.png"
                            : "assets/images/icon.png",
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Connexion!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                          ),
                        ],
                      ),
                    ),

                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 15, top: 20),
                          child: SizedBox(
                            height: 50.0,
                            child: TransAcademiaPhoneNumber(
                              number: 20,
                              controller: phoneController,
                              hintText: "Numéro de téléphone",
                              field: "phone",
                              fieldValue: state.field!["phone"],
                            ),
                          ));
                    }),

                    const SizedBox(
                      height: 20.0,
                    ),

                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            // padding:const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaPasswordField(
                                controller: passwordController,
                                label: "Mot de passe",
                                hintText: "Mot de passe",
                                field: "password",
                                fieldValue: state.field!["password"],
                              ),
                            ));
                      },
                    ),

                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (() => showToast("Bientôt disponible",
                                duration: 3, gravity: Toast.bottom)),
                            child: const Text(
                              "Mot de passe oublié ? ",
                              style:
                                  TextStyle(color: Colors.brown, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),

                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (state.field!["phone"] == "") {
                                  ValidationDialog.show(context,
                                      "Veuillez saisir le numéro de téléphone",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                if (state.field!["phone"].substring(0, 1) ==
                                        "0" ||
                                    state.field!["phone"].substring(0, 1) ==
                                        "+") {
                                  ValidationDialog.show(context,
                                      "Veuillez saisir le numéro avec le format valide, par exemple: (816644420).",
                                      () {
                                    print("modal");
                                  });
                                  return;
                                }

                                if (state.field!["phone"]
                                            .substring(0, 1) ==
                                        "1" ||
                                    state.field!["phone"]
                                            .substring(0, 1) ==
                                        "2" ||
                                    state.field!["phone"]
                                            .substring(0, 1) ==
                                        "3" ||
                                    state.field!["phone"]
                                            .substring(0, 1) ==
                                        "4" ||
                                    state.field!["phone"]
                                            .substring(0, 1) ==
                                        "5" ||
                                    state.field!["phone"].substring(0, 1) ==
                                        "6" ||
                                    state.field!["phone"].substring(0, 1) ==
                                        "7") {
                                  ValidationDialog.show(context,
                                      "Veuillez saisir le numéro avec le format valide, par exemple: (816644420).",
                                      () {
                                    print("modal");
                                  });
                                  return;
                                }

                                if (state.field!["password"] == "") {
                                  ValidationDialog.show(context,
                                      "le mot de passe ne doit pas être vide",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                TransAcademiaLoadingDialog.show(context);
                                Map? data = {
                                  "login": "0" + state.field!["phone"],
                                  "pwd": state.field!["password"],
                                  "IP_MAC": "357093539784400Zf",
                                  "NAME_DEVICE": "Galaxy A4 de Teddy",
                                  "IP_IMEI": "35709353978440Z0",
                                  "MODEL_DEVICE": "Android",
                                  "VERSION_OS": "13",
                                  "app_agent_version": "v1.01.2"
                                };

                                Map? response =
                                    await SignUpRepository.loginCream(data);
                                // print(response);

                                if (response["status"] == 200) {
                                  TransAcademiaLoadingDialog.stop(context);
                                  String? messageSucces =
                                      "Authentification effectué avec succès";
                                  TransAcademiaDialogSuccess.show(
                                      context, messageSucces, "Auth");

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('id',
                                      response['data']["agent_ID"].toString());
                                  prefs.setString('idUser',
                                      response['data']["user_ID"].toString());
                                  BlocProvider.of<SignupCubit>(context)
                                      .updateField(
                                          context,
                                          field: "idUser",
                                          data: response['data']["user_ID"]
                                              .toString());
                                  BlocProvider.of<SignupCubit>(context)
                                      .updateField(
                                          context,
                                          field: "idsite",
                                          data: response['data']["assignement"]
                                                  ["ID_sale_site"]
                                              .toString());
                                  prefs.setString(
                                      'idsite',
                                      response['data']["assignement"]
                                              ["ID_sale_site"]
                                          .toString());
                                  prefs.setString(
                                      'nomsite',
                                      response['data']["assignement"]
                                          ["sale_site"]);
                                  prefs.setString(
                                      'dateaffectation',
                                      response['data']["assignement"]
                                              ["affected_at"]
                                          .toString());

                                  prefs.setString(
                                      'fonction', response['data']["function"]);

                                  prefs.setString(
                                      'nom', response['data']["first_name"]);
                                  prefs.setString('postnom',
                                      response['data']["second_name"]);
                                  prefs.setString(
                                      'prenom', response['data']["third_name"]);

                                  try {
                                    Future.delayed(
                                        const Duration(milliseconds: 4000),
                                        () async {
                                      TransAcademiaDialogSuccess.stop(context);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/routestack',
                                              (Route<dynamic> route) => false);
                                    });
                                  } catch (e) {
                                    print("Exception during navigation: $e");
                                  }
                                } else if (response["status"] == 400) {
                                  TransAcademiaLoadingDialog.stop(context);
                                  TransAcademiaDialogError.show(
                                    context,
                                    response["message"],
                                    "login",
                                  );
                                  Future.delayed(
                                      const Duration(milliseconds: 4000), () {
                                    TransAcademiaDialogError.stop(context);
                                  });
                                } else {
                                  TransAcademiaLoadingDialog.stop(context);
                                  TransAcademiaDialogError.show(
                                      context, response["message"], "login");
                                }
                              },
                              child: const ButtonTransAcademia(
                                  title: "Se connecter"),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
