// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccessAbonnement.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialogPhone.dart';
import 'package:http/http.dart' as http;
import 'package:icecream_service/theme.dart';

class TransAcademiaDialogOTPParent {
  static show(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AdaptiveTheme.of(context).mode.name == "dark"
                            ? Colors.black
                            : Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 80,
                            // width: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AdaptiveTheme.of(context)
                                                .mode
                                                .name !=
                                            "dark"
                                        ? "assets/images/logo-kelasi.png"
                                        : "assets/images/logo-kelasi.png"))),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            "Code de vérification",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "Nous vous avons envoyé un code par SMS. Veuillez l'entrer ci-dessous.",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          BlocBuilder<AbonnementCubit, AbonnementState>(
                            builder: (context, stateAbonnement) {
                              return BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return OtpTextField(
                                    numberOfFields: 4,
                                    borderColor: Colors.blue,
                                    focusedBorderColor: kelasiColor,

                                    showFieldAsBox: true,

                                    onCodeChanged: (String code) {},

                                    onSubmit: (String verificationCode) async {
                                      TransAcademiaLoadingDialog.show(context); 
                                      Map data = {
                                        "login": state.field!["phone"],
                                        "pwd": state.field!["password"],
                                        "OTP": verificationCode
                                      };

                                      var response =
                                          await SignUpRepository.checkOtp(data);
                                      int status = response["status"];
                                      String? message = response["message"];

                                      if (status == 200) {
                                        TransAcademiaLoadingDialog.stop(context); 
                                        String? messageSucces =
                                            "La création de l'utilisateur a été effectuée avec succès";
                                        TransAcademiaDialogSuccess.show(
                                            context, messageSucces, "Auth");

                                        Future.delayed(
                                            const Duration(milliseconds: 4000),
                                            () async {
                                          TransAcademiaDialogSuccess.stop(
                                              context);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/loginkelasi',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      } else {
                                        TransAcademiaLoadingDialog.stop(
                                            context);

                                        TransAcademiaDialogError.show(
                                            context, message, "login");
                                      }
                                    }, // end onSubmit
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Vous n'avez pas reçu le code ? ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),

                          // const ButtonTransAcademia(title:"Valider"),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
