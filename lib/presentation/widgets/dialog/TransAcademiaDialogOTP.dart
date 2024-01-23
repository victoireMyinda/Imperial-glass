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
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccessAbonnement.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialogPhone.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownPayment.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:icecream_service/routestack.dart';
import 'package:icecream_service/theme.dart';
import 'package:http/http.dart' as http;

class TransAcademiaDialogOTP {
  static show(BuildContext context) {
    showDialog<void>(
        // barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          RegExp checkLengthNumber = RegExp("\d{9}[0-9]");
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
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
                              height: 30.0,
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
                                      numberOfFields: 6,
                                      borderColor: Colors.blue,
                                      //set to true to show as box or false to show as dash
                                      showFieldAsBox: true,
                                      //runs when a code is typed in
                                      onCodeChanged: (String code) {
                                        //handle validation or checks here
                                      },
                                      //runs when every textfield is filled
                                      onSubmit:
                                          (String verificationCode) async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        TransAcademiaLoadingDialogPhone.show(
                                            context);
                                        // abonnement

                                        int status;
                                        String? msg;
                                        try {
                                          await http.post(
                                              Uri.parse(
                                                  "https://tag.trans-academia.cd/Api_abonnement_test.php"),
                                              body: {
                                                // 'currency':
                                                //     state.field!["currency"],
                                                'provider': "RAKKA",
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'walletID': "243" +state.field!["phonePayment"],
                                                'etudiantID':
                                                    prefs.getString('code'),
                                                'abonnementID': stateAbonnement
                                                    .field!["abonnement"],
                                                    'otp_code': verificationCode,
                                                    'codetransaction': state.field!["codetransaction"]
                                              }).then((response) async {
                                            if (response.statusCode == 500 ||
                                                response.statusCode == 504 ||
                                                response.statusCode == 502) {
                                              TransAcademiaLoadingDialog.stop(
                                                  context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
                                                  "verification");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                return;
                                                // TransAcademiaDialogError.stop(
                                                //     context);
                                              });
                                            }

                                            int startIndex =
                                                response.body.indexOf('{');

                                            String jsonPart = response.body
                                                .substring(startIndex);

                                            var data = json.decode(jsonPart);

                                            status = data['status'];
                                            msg = data['msg'];
                                            if (status == 200) {
                                              // print("top");
                                              // TransAcademiaLoadingDialogPhone
                                              //     .stop(context);
                                              // TransAcademiaDialogOTP.show(
                                              //     context);

                                                     TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogSuccessAbonnement
                                                              .show(
                                                                  context,
                                                                  msg,
                                                                  "paiement");
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      5000),
                                                              () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                                    '/routestack',
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                          });
                                            } else if (status == 400) {
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  msg,
                                                  "prelevement");

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                TransAcademiaDialogError.stop(
                                                    context);
                                              });
                                            }else{
                                                         TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  msg,
                                                  "prelevement");

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                TransAcademiaDialogError.stop(
                                                    context);
                                              });

                                            }
                                          });
                                        } catch (e) {
                                          print(e);
                                        }
                                        // fin abonnement
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return AlertDialog(
                                        //         title: const Text("Verification Code"),
                                        //         content: Text(
                                        //             'Code entered is $verificationCode'),
                                        //       );
                                        //     });
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
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              height: 50.0,
                              // width: 150.0,
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
                                  "Valider",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
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
