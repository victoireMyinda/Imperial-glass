// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/webView/webviewHome.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogOTP.dart';
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

class TransAcademiaDialogLoginPayment {
  static show(BuildContext context, String? text, Function? onClose) {
    showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          RegExp checkLengthNumber = RegExp("\d{9}[0-9]");
          void showToast(String msg, {int? duration, int? gravity}) {
            Toast.show(msg, duration: duration, gravity: gravity);
          }

          ToastContext().init(context);
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 7.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AdaptiveTheme.of(context).mode.name == "dark"
                              ? Colors.black
                              : Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(context,
                                              field: "currency", data: "");
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: const Icon(Icons.close))),
                              ],
                            ),
                            Image.asset(
                              "assets/images/logo-trans1.png",
                              width: 60,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Text(
                                  "Finaliser le Prélèvement de ${double.parse(state.field!['prixUSD'])}\$ ou ${state.field!['prixCDF']} Fc pour la carte Trans-academia",
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                            const TransAcademiaDropdownPayment(
                              items: "paymentData",
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, top: 20),
                                  child: SizedBox(
                                    height: 50.0,
                                    child: TransAcademiaPhoneNumber(
                                      number: 20,
                                      hintText: "Numéro de téléphone",
                                      field: "phonePayment",
                                      fieldValue: state.field!["phone"],
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10.0,
                            ),
                            // BlocBuilder<SignupCubit, SignupState>(
                            //   builder: (context, state) {
                            //     return Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             RoundCheckBox(
                            //               onTap: (selected) {
                            //                 BlocProvider.of<SignupCubit>(
                            //                         context)
                            //                     .updateField(context,
                            //                         field: "currency",
                            //                         data: "USD");
                            //               },
                            //               size: 25,
                            //               checkedColor: primaryColor,
                            //               isChecked:
                            //                   state.field!["currency"] == "USD"
                            //                       ? true
                            //                       : false,
                            //               animationDuration: const Duration(
                            //                 milliseconds: 50,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //               width: 20.0,
                            //             ),
                            //             const Text("USD")
                            //           ],
                            //         ),
                            //         Row(
                            //           children: [
                            //             RoundCheckBox(
                            //               onTap: (selected) {
                            //                 BlocProvider.of<SignupCubit>(
                            //                         context)
                            //                     .updateField(context,
                            //                         field: "currency",
                            //                         data: "CDF");
                            //               },
                            //               size: 25,
                            //               checkedColor: primaryColor,
                            //               isChecked:
                            //                   state.field!["currency"] == "CDF"
                            //                       ? true
                            //                       : false,
                            //               animationDuration: const Duration(
                            //                 milliseconds: 50,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //               width: 20.0,
                            //             ),
                            //             const Text("CDF")
                            //           ],
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // ),

                            const SizedBox(
                              height: 20.0,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () async {
                                    BlocProvider.of<SignupCubit>(context)
                                        .updateField(context,
                                            field: "currency", data: "USD");

                                    if (state.field!["typePaymentFromApi"] ==
                                        "") {
                                      ValidationDialog.show(context,
                                          "Veuillez choisir le moyen de paiement",
                                          () {
                                        print("modal");
                                      });
                                      return;
                                    }


                                    if (state.field!["phonePayment"] == "") {
                                      ValidationDialog.show(context,
                                          "le numéro ne doit pas être vide",
                                          () {
                                        print("modal");
                                      });
                                      return;
                                    }

                                    //send data in api
                                    // ignore: unused_local_variable
                                    if (state.field!["phonePayment"]
                                                .substring(0, 1) ==
                                            "0" ||
                                        state.field!["phonePayment"]
                                                .substring(0, 1) ==
                                            "+") {
                                      ValidationDialog.show(context,
                                          "Veuillez saisir le numéro avec le format valide, par exemple: (826016607).",
                                          () {
                                        print("modal");
                                        return;
                                      });
                                    }

                                    // check connexion
                                    try {
                                      final response =
                                          await InternetAddress.lookup(
                                              'www.google.com');
                                      if (response.isNotEmpty) {
                                        print("connected");
                                      }
                                    } on SocketException catch (err) {
                                      ValidationDialog.show(context,
                                          "Pas de connexion internet !", () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    //send data in api

                                    // copy code

                                    var provider;

                                    if (state.field!["typePaymentFromApi"] ==
                                        "MPESA") {
                                      // MPESA
                                      provider = "MPESA";
                                      if (state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "81" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "82" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "83") {
                                        // process payment
                                        TransAcademiaLoadingDialogPhone.show(
                                            context);
                                        // prelevement

                                        int status;
                                        var msg;

                                        try {
                                          await http.post(
                                              Uri.parse(
                                                  "https://tag.trans-academia.cd/TransactionPrelevements_API.php"),
                                              body: {
                                                'gatewayMode': "1",
                                                'IDabonnement':
                                                    state.field!["abonnement"],
                                                'currency':
                                                    state.field!["currency"],
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "chanel": "MOBILEMONEY",
                                                'provider': provider,
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'walletID': "243" +
                                                    state
                                                        .field!["phonePayment"],
                                                'IDetudiant':
                                                    state.field!["id"],
                                              }).then((response) async {
                                            if (response.statusCode == 500 ||
                                                response.statusCode == 504) {
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
                                                  "verification");
                                              return;
                                            }

                                            var data =
                                                json.decode(response.body);

                                            status = data['status'];
                                            msg = data['msg'];
                                            if (status == 201) {
                                              // print("top");
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              // Navigator.of(context).pop();
                                              TransAcademiaDialogSuccessAbonnement
                                                  .show(
                                                      context, msg, "paiement");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        '/login',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              });
                                            } else if (status == 400) {
                                              // TransAcademiaLoadingDialog.stop(
                                              //     context);

                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);

                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
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

                                        // fin prelevement

                                        // fin process payment
                                      } else {
                                        ValidationDialog.show(context,
                                            "Veuillez saisir un numéro Vodacom valide, par exemple: (826016607)",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                    } else if (state
                                            .field!["typePaymentFromApi"] ==
                                        "ORANGE") {
                                      // ORANGE
                                      provider = "ORANGE";
                                      if (state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "89" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "85" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "84" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "80") {
                                        // process payment
                                        TransAcademiaLoadingDialogPhone.show(
                                            context);
                                        // prelevement

                                        int status;
                                        try {
                                          await http.post(Uri.parse(
                                              // "https://api.trans-academia.cd/Trans_prelevements.php"
                                              "https://tag.trans-academia.cd/TransactionPrelevements_API.php"), body: {
                                            'gatewayMode': "1",
                                            'IDabonnement':
                                                state.field!["abonnement"],
                                            'currency':
                                                state.field!["currency"],
                                            // ignore: prefer_interpolation_to_compose_strings
                                            "chanel": "MOBILEMONEY",
                                            'provider': provider,
                                            // ignore: prefer_interpolation_to_compose_strings
                                            'walletID': "0" +
                                                state.field!["phonePayment"],
                                            'IDetudiant': state.field!["id"],
                                          }).then((response) async {
                                            if (response.statusCode == 500 ||
                                                response.statusCode == 504) {
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
                                                  "verification");
                                              return;
                                            }

                                            var data =
                                                json.decode(response.body);

                                            status = data['status'];
                                            if (status == 200) {
                                              // print("top");
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogSuccess.show(
                                                  context,
                                                  "votre prélèvement à été traité avec succès",
                                                  "paiement");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        '/login',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              });
                                            } else if (status == 400) {
                                              TransAcademiaLoadingDialog.stop(
                                                  context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
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

                                        // fin prelevement

                                      } else {
                                        ValidationDialog.show(context,
                                            "Veuillez saisir un numéro Orange valide, par exemple: (896016607)",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                    } else if (state
                                            .field!["typePaymentFromApi"] ==
                                        "AIRTEL") {
                                      // Airtel
                                      provider = "AIRTEL";
                                      if (state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "99" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "98" ||
                                          state.field!["phonePayment"]
                                                  .substring(0, 2) ==
                                              "97") {
                                        // process payment

                                        TransAcademiaLoadingDialogPhone.show(
                                            context);
                                        // prelevement

                                        int status;
                                        try {
                                          await http.post(
                                              Uri.parse(
                                                  "https://api.trans-academia.cd/Trans_prelevements.php"),
                                              body: {
                                                'gatewayMode': "1",
                                                'IDabonnement':
                                                    state.field!["abonnement"],
                                                // 'amount': state.field![
                                                //             "currency"] ==
                                                //         "USD"
                                                //     ? state.field!['prixUSD']
                                                //     : state.field!['prixCDF'],
                                                // : "100",
                                                'currency':
                                                    state.field!["currency"],
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "chanel": "MOBILEMONEY",
                                                'provider': provider,
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'walletID': "243" +
                                                    state
                                                        .field!["phonePayment"],
                                                'IDetudiant':
                                                    state.field!["id"],
                                              }).then((response) async {
                                            if (response.statusCode == 500 ||
                                                response.statusCode == 504) {
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
                                                  "verification");
                                              return;
                                            }

                                            var data =
                                                json.decode(response.body);

                                            status = data['status'];
                                            if (status == 200) {
                                              // print("top");
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogSuccess.show(
                                                  context,
                                                  "votre prélèvement à été traité avec succès",
                                                  "paiement");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        '/login',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              });
                                            } else if (status == 400) {
                                              TransAcademiaLoadingDialog.stop(
                                                  context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
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

                                        // fin prelevement

                                      } else {
                                        ValidationDialog.show(context,
                                            "Veuillez saisir un numéro Airtel valide, par exemple: (996016607)",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                    } else if (state
                                            .field!["typePaymentFromApi"] ==
                                        "ILLICOCASH") {
                                      // Airtel
                                      provider = "ILLICOCASH";
                                      showToast("Bientôt disponible",
                                          duration: 3, gravity: Toast.bottom);
                                      return;
                                      // Navigator.of(context).pop();
                                      // TransAcademiaDialogOTP.show(context);

                                    } else if (state
                                            .field!["typePaymentFromApi"] ==
                                        "PEPELEMOBILE") {
                                      var prixUSDFirst = double.parse(
                                              state.field!["prixUSD"]) *
                                          100;

                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebViewApp(
                                                  amount: state.field![
                                                              "currency"] ==
                                                          "CDF"
                                                      ? state.field!["prixCDF"]
                                                      : prixUSDFirst
                                                          .toStringAsFixed(2),
                                                  currency:
                                                      state.field!["currency"],
                                                  phonenumber: "243" +
                                                      state.field![
                                                          "phonePayment"],
                                                )),
                                      );
                                    } else {
                                      // Africel
                                      provider = "AFRICEL";
                                      if (state.field!["phonePayment"]
                                              .substring(0, 2) ==
                                          "90") {
                                        // process payment
                                        TransAcademiaLoadingDialogPhone.show(
                                            context);
                                        // prelevement

                                        int status;
                                        try {
                                          await http.post(
                                              Uri.parse(
                                                  "https://api.trans-academia.cd/Trans_prelevements.php"),
                                              body: {
                                                'gatewayMode': "1",
                                                'IDabonnement':
                                                    state.field!["abonnement"],
                                                // 'amount': state.field![
                                                //             "currency"] ==
                                                //         "USD"
                                                //     ? state.field!['prixUSD']
                                                //     : state.field!['prixCDF'],
                                                // : "100",
                                                'currency':
                                                    state.field!["currency"],
                                                // ignore: prefer_interpolation_to_compose_strings
                                                "chanel": "MOBILEMONEY",
                                                'provider': provider,
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'walletID': "243" +
                                                    state
                                                        .field!["phonePayment"],
                                                'IDetudiant':
                                                    state.field!["id"],
                                              }).then((response) async {
                                            if (response.statusCode == 500 ||
                                                response.statusCode == 504) {
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
                                                  "verification");
                                              return;
                                            }

                                            var data =
                                                json.decode(response.body);

                                            status = data['status'];
                                            if (status == 200) {
                                              // print("top");
                                              TransAcademiaLoadingDialogPhone
                                                  .stop(context);
                                              TransAcademiaDialogSuccess.show(
                                                  context,
                                                  "votre prélèvement à été traité avec succès",
                                                  "paiement");
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000), () {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        '/login',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              });
                                            } else if (status == 400) {
                                              TransAcademiaLoadingDialog.stop(
                                                  context);
                                              TransAcademiaDialogError.show(
                                                  context,
                                                  "Erreur de paiement",
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

                                        // fin prelevement

                                      } else {
                                        ValidationDialog.show(context,
                                            "Veuillez saisir un numéro Africel valide, par exemple: (906016607)",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                    }

                                    // fin copy code

                                    // //
                                    // if (state.field!["typePayment"] == "1") {
                                    //   //payment Illicocash

                                    //   Navigator.of(context).pop();
                                    //   TransAcademiaDialogOTP.show(context);
                                    // } else {
                                    //   //payment Mobile

                                    //   if (state.field!["currency"] == "") {
                                    //     ValidationDialog.show(context,
                                    //         "Veuillez choisir la devise", () {
                                    //       print("modal");
                                    //     });
                                    //     return;
                                    //   }

                                    //   if (state.field!["phonePayment"] == "") {
                                    //     ValidationDialog.show(context,
                                    //         "le numéro ne doit pas être vide",
                                    //         () {
                                    //       print("modal");
                                    //     });
                                    //     return;
                                    //   }

                                    //   //send data in api
                                    //   // ignore: unused_local_variable
                                    //   var provider;
                                    //   if (state.field!["phonePayment"]
                                    //               .substring(0, 1) ==
                                    //           "0" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 1) ==
                                    //           "+") {
                                    //     ValidationDialog.show(context,
                                    //         "Veuillez saisir le numéro avec le format valide, par exemple: (826016607).",
                                    //         () {
                                    //       print("modal");
                                    //       return;
                                    //     });
                                    //   }

                                    //   // if (!checkLengthNumber.hasMatch(state.field!["phonePayment"])) {
                                    //   //   ValidationDialog.show(context,
                                    //   //       "Veuillez inseré un numero avec 9 chiffres.",
                                    //   //       () {
                                    //   //     print("modal");
                                    //   //     return;
                                    //   //   });
                                    //   // }

                                    //   if (state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "81" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "82" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "83") {
                                    //     provider = "MPESA";
                                    //   } else if (state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "89" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "85" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "84" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "80") {
                                    //     provider = "ORANGE";
                                    //   } else if (state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "99" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "98" ||
                                    //       state.field!["phonePayment"]
                                    //               .substring(0, 2) ==
                                    //           "97") {
                                    //     provider = "AIRTEL";
                                    //   } else {
                                    //     provider = "AFRICEL";
                                    //   }

                                    //   TransAcademiaLoadingDialogPhone.show(
                                    //       context);
                                    //   // prelevement

                                    //   int status;
                                    //       try {
                                    //         await http.post(
                                    //             Uri.parse(
                                    //                 "https://api.trans-academia.cd/Trans_prelevements.php"),
                                    //             body: {
                                    //               'gatewayMode': "1",
                                    //               'amount': state.field![
                                    //                           "currency"] ==
                                    //                       "USD"
                                    //                   ? state.field!['prixUSD']
                                    //                   : state.field!['prixCDF'],
                                    //                   // : "100",
                                    //               'currency':
                                    //                   state.field!["currency"],
                                    //               // ignore: prefer_interpolation_to_compose_strings
                                    //               "chanel": "MOBILEMONEY",
                                    //               'provider': provider,
                                    //               // ignore: prefer_interpolation_to_compose_strings
                                    //               'walletID': "243" +
                                    //                   state.field![
                                    //                       "phonePayment"],
                                    //               'IDetudiant':
                                    //                   state.field!["id"],
                                    //             }).then((response) async {
                                    //           if (response.statusCode == 500 ||
                                    //               response.statusCode == 504) {
                                    //             TransAcademiaLoadingDialogPhone
                                    //                 .stop(context);
                                    //             TransAcademiaDialogError.show(
                                    //                 context,
                                    //                 "Erreur de paiement",
                                    //                 "verification");
                                    //             return;
                                    //           }

                                    //           var data =
                                    //               json.decode(response.body);

                                    //           status = data['status'];
                                    //           if (status == 200) {
                                    //             // print("top");
                                    //             TransAcademiaLoadingDialogPhone
                                    //                 .stop(context);
                                    //             TransAcademiaDialogSuccess.show(
                                    //                 context,
                                    //                 "votre prélèvement à été traité avec succès",
                                    //                 "paiement");
                                    //             Future.delayed(
                                    //                 const Duration(
                                    //                     milliseconds: 3000),
                                    //                 () {
                                    //               Navigator.of(context)
                                    //                   .pushNamedAndRemoveUntil(
                                    //                       '/login',
                                    //                       (Route<dynamic>
                                    //                               route) =>
                                    //                           false);
                                    //             });
                                    //           } else if (status == 400) {
                                    //             TransAcademiaLoadingDialog.stop(
                                    //                 context);
                                    //             TransAcademiaDialogError.show(
                                    //                 context,
                                    //                 "Erreur de paiement",
                                    //                 "prelevement");

                                    //             Future.delayed(
                                    //                 const Duration(
                                    //                     milliseconds: 3000),
                                    //                 () {
                                    //               TransAcademiaDialogError.stop(
                                    //                   context);
                                    //             });
                                    //           }
                                    //         });
                                    //       } catch (e) {
                                    //         print(e);
                                    //       }

                                    // fin prelevement

                                    // }
                                  },
                                  child: Container(
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
                                        "Payer",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
