// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/webView/webviewHome.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogOTP.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialogPhone.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownPayment.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:icecream_service/theme.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class TransAcademiaDialog {
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
              // BlocProvider.of<SignupCubit>(context)
              //                         .updateField(context,
              //                             field: "phonePayment",
              //                             data: "");
              
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
                                  "Prélèvement de ${double.parse(state.field!['prixUSD']).round()}\$ ou ${state.field!['prixCDF']} Fc pour la carte Trans-academia",
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
                                  child: const SizedBox(
                                    height: 50.0,
                                    child: TransAcademiaPhoneNumber(
                                      number: 20,
                                      hintText: "Numéro de téléphone",
                                      field: "phonePayment",
                                      fieldValue: "",
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10.0,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        RoundCheckBox(
                                          onTap: (selected) {
                                            BlocProvider.of<SignupCubit>(
                                                    context)
                                                .updateField(context,
                                                    field: "currency",
                                                    data: "USD");
                                          },
                                          size: 25,
                                          checkedColor: primaryColor,
                                          isChecked:
                                              state.field!["currency"] == "USD"
                                                  ? true
                                                  : false,
                                          animationDuration: const Duration(
                                            milliseconds: 50,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        const Text("USD")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        RoundCheckBox(
                                          onTap: (selected) {
                                            BlocProvider.of<SignupCubit>(
                                                    context)
                                                .updateField(context,
                                                    field: "currency",
                                                    data: "CDF");
                                          },
                                          size: 25,
                                          checkedColor: primaryColor,
                                          isChecked:
                                              state.field!["currency"] == "CDF"
                                                  ? true
                                                  : false,
                                          animationDuration: const Duration(
                                            milliseconds: 50,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        const Text("CDF")
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () async {
                                    // new payment
                                    if (state.field!["typePaymentFromApi"] ==
                                        "") {
                                      ValidationDialog.show(context,
                                          "Veuillez choisir le moyen de paiement",
                                          () {
                                        print("modal");
                                      });
                                      return;
                                    }

                                    if (state.field!["currency"] == "") {
                                      ValidationDialog.show(
                                          context, "Veuillez choisir la devise",
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

                                    if (state.field!["phonePayment"].length <
                                        9) {
                                      ValidationDialog.show(context,
                                          "Le numéro de paiement ne doit pas avoir moins de 9 chiffres",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    // check connexion
                                    try {
                                      final response = await InternetAddress.lookup(
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

                                    var provider;

                                    if (state.field!["typePaymentFromApi"] == "MPESA") {

                                          // MPESA
                                          provider = "MPESA";
                                          if (state.field!["phonePayment"].substring(0, 2) =="81" || state.field!["phonePayment"].substring(0, 2) =="82" ||
                                              state.field!["phonePayment"].substring(0, 2) =="83") {
                                            // process payment
                                                        TransAcademiaLoadingDialogPhone.show(context);
                                                        int status;
                                                        try {
                                                          var dio = Dio();
                                                          var response = await dio.post(
                                                              "https://api.trans-academia.cd/Trans_Inscription.php",
                                                              data: {
                                                                "App_name": "app",
                                                                "token": "2022",
                                                                "nom": state.field!["nom"],
                                                                "postnom":
                                                                    state.field!["postnom"],
                                                                "prenom": state.field!["prenom"],
                                                                "sexe": state.field!["sexe"],
                                                                "telephone":
                                                                    "0" + state.field!["phone"],
                                                                "email": state.field!["email"],
                                                                "lieuNaissance":
                                                                    state.field!["lieuNaissance"],
                                                                "avenue": state.field!["avenue"],
                                                                "numero": state.field!["phone"],
                                                                "DateNaissance":
                                                                    state.field!["dateNaissance"],
                                                                "ID_etudiant": state.field!["id"],
                                                                // "id_promotion":
                                                                //     state.field!["promotion"],
                                                                "password":
                                                                    state.field!["password"],
                                                                "province":
                                                                    state.field!["province"],
                                                                "commune":
                                                                    state.field!["commune"],
                                                                "ville":
                                                                    state.field!["ville"],
                                                              });
                                                          var data = response.data;
                                                          print(data);
                                                          status = data['status'];
                                                          // ignore: duplicate_ignore
                                                          if (status == 201) {
                                                            // ignore: use_build_context_synchronously
                                                            TransAcademiaDialogError.show(
                                                                context,
                                                                "Vous avez déjà un compte avec ce numéro ",
                                                                "paiement");
                                                            BlocProvider.of<SignupCubit>(context)
                                                                .updateField(context,
                                                                    field: "phone",
                                                                    data: state.field!["phone"]);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds: 4000), () {
                                                              Navigator.of(context)
                                                                  .pushNamedAndRemoveUntil(
                                                                      '/login',
                                                                      (Route<dynamic> route) =>
                                                                          false);
                                                            });
                                                          } else if (status == 200) {
                                                            // upload image

                                                            var request = http.MultipartRequest(
                                                                'POST',
                                                                Uri.parse(
                                                                    'https://tag.trans-academia.cd/Trans-upload-image.php'));
                                                            request.fields.addAll({
                                                              'App_name': 'app',
                                                              'token': '2022',
                                                              'id': state.field!['id']
                                                            });
                                                            request.files.add(
                                                                await http.MultipartFile.fromPath(
                                                                    'photo',
                                                                    state.field!['filePath']));

                                                            http.StreamedResponse response =
                                                                await request.send();

                                                            if (response.statusCode == 200) {
                                                              // create a prelevement

                                                              int status;
                                                              try {
                                                                await http.post(
                                                                    Uri.parse(
                                                                        "https://api.trans-academia.cd/Trans_prelevements.php"),
                                                                    body: {
                                                                      'gatewayMode': "1",
                                                                      'IDabonnement': state.field!["abonnement"],

                                                                      // 'amount': state.field![
                                                                      //             "currency"] ==
                                                                      //         "USD"
                                                                      //     ? state
                                                                      //         .field!['prixUSD']
                                                                      //     : state
                                                                      //         .field!['prixCDF'],
                                                                      'currency': state
                                                                          .field!["currency"],
                                                                      // ignore: prefer_interpolation_to_compose_strings
                                                                      "chanel": "MOBILEMONEY",
                                                                      'provider': provider,
                                                                      // ignore: prefer_interpolation_to_compose_strings
                                                                      'walletID': "243" +
                                                                          state.field![
                                                                              "phonePayment"],
                                                                      'IDetudiant':
                                                                          state.field!["id"],
                                                                    }).then((response) async {
                                                                  if (response.statusCode ==
                                                                          500 ||
                                                                      response.statusCode ==
                                                                          504) {
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
                                                                            milliseconds: 3000),
                                                                        () {
                                                                      Navigator.of(context)
                                                                          .pushNamedAndRemoveUntil(
                                                                              '/login',
                                                                              (Route<dynamic>
                                                                                      route) =>
                                                                                  false);
                                                                    });
                                                                  } else if (status == 400) {
                                                                    TransAcademiaLoadingDialog
                                                                        .stop(context);
                                                                    TransAcademiaDialogError.show(
                                                                        context,
                                                                        "Erreur de paiement",
                                                                        "prelevement");

                                                                    Future.delayed(
                                                                        const Duration(
                                                                            milliseconds: 3000),
                                                                        () {
                                                                      TransAcademiaDialogError
                                                                          .stop(context);
                                                                    });
                                                                  }
                                                                });
                                                              } catch (e) {
                                                                print(e);
                                                              }

                                                              //end prelevement

                                                            } else {
                                                              TransAcademiaLoadingDialogPhone
                                                                  .stop(context);
                                                              TransAcademiaDialogError.show(
                                                                  context,
                                                                  "Erreur de téléchargement pour l'image",
                                                                  "verification");
                                                            }

                                                            // end upload image

                                                            // ignore: use_build_context_synchronously

                                                          } else {
                                                            // ignore: use_build_context_synchronously
                                                            TransAcademiaLoadingDialog.stop(
                                                                context);
                                                            // ignore: use_build_context_synchronously
                                                            TransAcademiaDialogError.show(
                                                                context,
                                                                "Echec d'enregistrement",
                                                                "verification");

                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds: 4000), () {
                                                              TransAcademiaDialogError.stop(
                                                                  context);
                                                            });
                                                          }
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                        

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

                                    } else if (state.field!["typePaymentFromApi"] == "ORANGE" ) {
                                          // ORANGE
                                          provider = "ORANGE";
                                            if (state.field!["phonePayment"].substring(0, 2) == "89" || state.field!["phonePayment"].substring(0, 2) == "85" ||
                                            state.field!["phonePayment"].substring(0, 2) =="84" || state.field!["phonePayment"].substring(0, 2) =="80")  {
                                              // process payment
                                                TransAcademiaLoadingDialogPhone.show(context);
                                                int status;
                                                try {
                                                  var dio = Dio();
                                                  var response = await dio.post(
                                                      "https://api.trans-academia.cd/Trans_Inscription.php",
                                                      data: {
                                                        "App_name": "app",
                                                        "token": "2022",
                                                        "nom": state.field!["nom"],
                                                        "postnom":
                                                            state.field!["postnom"],
                                                        "prenom": state.field!["prenom"],
                                                        "sexe": state.field!["sexe"],
                                                        "telephone":
                                                            "0" + state.field!["phone"],
                                                        "email": state.field!["email"],
                                                        "lieuNaissance":
                                                            state.field!["lieuNaissance"],
                                                        "avenue": state.field!["avenue"],
                                                        "numero": state.field!["phone"],
                                                        "DateNaissance":
                                                            state.field!["dateNaissance"],
                                                        "ID_etudiant": state.field!["id"],
                                                        // "id_promotion":
                                                        //     state.field!["promotion"],
                                                        "password": state.field!["password"],
                                                        "province": state.field!["province"],
                                                        "commune": state.field!["commune"],
                                                        "ville": state.field!["ville"],
                                                      });
                                                  var data = response.data;
                                                  print(data);
                                                  status = data['status'];
                                                  // ignore: duplicate_ignore
                                                  if (status == 201) {
                                                    // ignore: use_build_context_synchronously
                                                    TransAcademiaDialogError.show(
                                                        context,
                                                        "Vous avez déjà un compte avec ce numéro ",
                                                        "paiement");
                                                    BlocProvider.of<SignupCubit>(context)
                                                        .updateField(context,
                                                            field: "phone",
                                                            data: state.field!["phone"]);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 4000), () {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              '/login',
                                                              (Route<dynamic> route) =>
                                                                  false);
                                                    });
                                                  } else if (status == 200) {
                                                    // upload image

                                                    var request = http.MultipartRequest(
                                                        'POST',
                                                        Uri.parse(
                                                            'https://tag.trans-academia.cd/Trans-upload-image.php'));
                                                    request.fields.addAll({
                                                      'App_name': 'app',
                                                      'token': '2022',
                                                      'id': state.field!['id']
                                                    });
                                                    request.files.add(
                                                        await http.MultipartFile.fromPath(
                                                            'photo',
                                                            state.field!['filePath']));

                                                    http.StreamedResponse response =
                                                        await request.send();

                                                    if (response.statusCode == 200) {
                                                      // create a prelevement

                                                              int status;
                                                              try {
                                                                await http.post(
                                                                    Uri.parse(
                                                                        // "https://api.trans-academia.cd/Trans_prelevements.php"
                                                                        "https://api.trans-academia.cd/TransactionPrelevements_API.php"
                                                                        ),
                                                                    body: {
                                                                      'gatewayMode': "1",
                                                                      'IDabonnement': state.field!["abonnement"],
                                                                      // 'amount': state.field![
                                                                      //             "currency"] ==
                                                                      //         "USD"
                                                                      //     ? state
                                                                      //         .field!['prixUSD']
                                                                      //     : state.field!['prixCDF'],
                                                                      'currency': state
                                                                          .field!["currency"],
                                                                      // ignore: prefer_interpolation_to_compose_strings
                                                                      "chanel": "MOBILEMONEY",
                                                                      'provider': provider,
                                                                      // ignore: prefer_interpolation_to_compose_strings
                                                                      'walletID': "0" +
                                                                          state.field![
                                                                              "phonePayment"],
                                                                      'IDetudiant':
                                                                          state.field!["id"],
                                                                    }).then((response) async {
                                                                  if (response.statusCode ==
                                                                          500 ||
                                                                      response.statusCode ==
                                                                          504) {
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
                                                                            milliseconds: 3000),
                                                                        () {
                                                                      Navigator.of(context)
                                                                          .pushNamedAndRemoveUntil(
                                                                              '/login',
                                                                              (Route<dynamic>
                                                                                      route) =>
                                                                                  false);
                                                                    });
                                                                  } else if (status == 400) {
                                                                    TransAcademiaLoadingDialog
                                                                        .stop(context);
                                                                    TransAcademiaDialogError.show(
                                                                        context,
                                                                        "Erreur de paiement",
                                                                        "prelevement");

                                                                    Future.delayed(
                                                                        const Duration(
                                                                            milliseconds: 3000),
                                                                        () {
                                                                      TransAcademiaDialogError
                                                                          .stop(context);
                                                                    });
                                                                  }
                                                                });
                                                              } catch (e) {
                                                                print(e);
                                                              }

                                                              //end prelevement

                                                            } else {
                                                              TransAcademiaLoadingDialogPhone
                                                                  .stop(context);
                                                              TransAcademiaDialogError.show(
                                                                  context,
                                                                  "Erreur de téléchargement pour l'image",
                                                                  "verification");
                                                            }

                                                            // end upload image

                                                            // ignore: use_build_context_synchronously

                                                          } else {
                                                            // ignore: use_build_context_synchronously
                                                            TransAcademiaLoadingDialog.stop(
                                                                context);
                                                            // ignore: use_build_context_synchronously
                                                            TransAcademiaDialogError.show(
                                                                context,
                                                                "Echec d'enregistrement",
                                                                "verification");

                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds: 4000), () {
                                                              TransAcademiaDialogError.stop(
                                                                  context);
                                                            });
                                                          }
                                                        } catch (e) {
                                                          print(e);
                                                        }
              


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


                                    } else if (state.field!["typePaymentFromApi"] == "AIRTEL" ) {
                                            // Airtel
                                            provider = "AIRTEL";
                                            if (state.field!["phonePayment"].substring(0, 2) =="99" || state.field!["phonePayment"].substring(0, 2) == "98"
                                             ||state.field!["phonePayment"].substring(0, 2) =="97") {
                                              // process payment

                                                          TransAcademiaLoadingDialogPhone.show(context);                                                       TransAcademiaLoadingDialogPhone.show(context);
                                                          int status;
                                                          try {
                                                            var dio = Dio();
                                                            var response = await dio.post(
                                                                "https://api.trans-academia.cd/Trans_Inscription.php",
                                                                data: {
                                                                  "App_name": "app",
                                                                  "token": "2022",
                                                                  "nom": state.field!["nom"],
                                                                  "postnom":
                                                                      state.field!["postnom"],
                                                                  "prenom": state.field!["prenom"],
                                                                  "sexe": state.field!["sexe"],
                                                                  "telephone":
                                                                      "0" + state.field!["phone"],
                                                                  "email": state.field!["email"],
                                                                  "lieuNaissance":
                                                                      state.field!["lieuNaissance"],
                                                                  "avenue": state.field!["avenue"],
                                                                  "numero": state.field!["phone"],
                                                                  "DateNaissance":
                                                                      state.field!["dateNaissance"],
                                                                  "ID_etudiant": state.field!["id"],
                                                                  // "id_promotion":
                                                                  //     state.field!["promotion"],
                                                                  "password":
                                                                      state.field!["password"],
                                                                  "province": state.field!["province"],
                                                                  "commune": state.field!["commune"],
                                                                  "ville": state.field!["ville"],
                                                                });
                                                            var data = response.data;
                                                            print(data);
                                                            status = data['status'];
                                                            // ignore: duplicate_ignore
                                                            if (status == 201) {
                                                              // ignore: use_build_context_synchronously
                                                              TransAcademiaDialogError.show(
                                                                  context,
                                                                  "Vous avez déjà un compte avec ce numéro ",
                                                                  "paiement");
                                                              BlocProvider.of<SignupCubit>(context)
                                                                  .updateField(context,
                                                                      field: "phone",
                                                                      data: state.field!["phone"]);
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds: 4000), () {
                                                                Navigator.of(context)
                                                                    .pushNamedAndRemoveUntil(
                                                                        '/login',
                                                                        (Route<dynamic> route) =>
                                                                            false);
                                                              });
                                                            } else if (status == 200) {
                                                              // upload image

                                                              var request = http.MultipartRequest(
                                                                  'POST',
                                                                  Uri.parse(
                                                                      'https://tag.trans-academia.cd/Trans-upload-image.php'));
                                                              request.fields.addAll({
                                                                'App_name': 'app',
                                                                'token': '2022',
                                                                'id': state.field!['id']
                                                              });
                                                              request.files.add(
                                                                  await http.MultipartFile.fromPath(
                                                                      'photo',
                                                                      state.field!['filePath']));

                                                              http.StreamedResponse response =
                                                                  await request.send();

                                                              if (response.statusCode == 200) {
                                                                // create a prelevement

                                                                int status;
                                                                try {
                                                                  await http.post(
                                                                      Uri.parse(
                                                                          "https://api.trans-academia.cd/Trans_prelevements.php"),
                                                                      body: {
                                                                        'gatewayMode': "1",
                                                                        'IDabonnement': state.field!["abonnement"],
                                                                        // 'amount': state.field![
                                                                        //             "currency"] ==
                                                                        //         "USD"
                                                                        //     ? state
                                                                        //         .field!['prixUSD']
                                                                        //     : state
                                                                        //         .field!['prixCDF'],
                                                                        'currency': state
                                                                            .field!["currency"],
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        "chanel": "MOBILEMONEY",
                                                                        'provider': provider,
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        'walletID': "243" +
                                                                            state.field![
                                                                                "phonePayment"],
                                                                        'IDetudiant':
                                                                            state.field!["id"],
                                                                      }).then((response) async {
                                                                    if (response.statusCode ==
                                                                            500 ||
                                                                        response.statusCode ==
                                                                            504) {
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
                                                                              milliseconds: 3000),
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pushNamedAndRemoveUntil(
                                                                                '/login',
                                                                                (Route<dynamic>
                                                                                        route) =>
                                                                                    false);
                                                                      });
                                                                    } else if (status == 400) {
                                                                      TransAcademiaLoadingDialog
                                                                          .stop(context);
                                                                      TransAcademiaDialogError.show(
                                                                          context,
                                                                          "Erreur de paiement",
                                                                          "prelevement");

                                                                      Future.delayed(
                                                                          const Duration(
                                                                              milliseconds: 3000),
                                                                          () {
                                                                        TransAcademiaDialogError
                                                                            .stop(context);
                                                                      });
                                                                    }
                                                                  });
                                                                } catch (e) {
                                                                  print(e);
                                                                }

                                                                //end prelevement

                                                              } else {
                                                                TransAcademiaLoadingDialogPhone
                                                                    .stop(context);
                                                                TransAcademiaDialogError.show(
                                                                    context,
                                                                    "Erreur de téléchargement pour l'image",
                                                                    "verification");
                                                              }

                                                              // end upload image

                                                              // ignore: use_build_context_synchronously

                                                            } else {
                                                              // ignore: use_build_context_synchronously
                                                              TransAcademiaLoadingDialog.stop(
                                                                  context);
                                                              // ignore: use_build_context_synchronously
                                                              TransAcademiaDialogError.show(
                                                                  context,
                                                                  "Echec d'enregistrement",
                                                                  "verification");

                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds: 4000), () {
                                                                TransAcademiaDialogError.stop(
                                                                    context);
                                                              });
                                                            }
                                                          } catch (e) {
                                                            print(e);
                                                          }



                                              


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


                                    }else if (state.field!["typePaymentFromApi"] == "ILLICOCASH" ) {
                                            // Airtel
                                            provider = "ILLICOCASH";
                                            showToast("Bientôt disponible",duration: 3, gravity: Toast.bottom);
                                            return;
                                            // Navigator.of(context).pop();
                                            // TransAcademiaDialogOTP.show(context);

                                        


                                    }else if (state.field!["typePaymentFromApi"] == "PEPELEMOBILE" ) {


                                            var prixUSDFirst = double.parse(state.field!["prixUSD"]) * 100;

                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => WebViewApp(amount: state.field!["currency"] == "CDF"?state.field!["prixCDF"]:prixUSDFirst.toStringAsFixed(2), currency: state.field!["currency"], phonenumber: "243" +state.field!["phonePayment"],)),
                                            );
                                  


                                    }else {
                                            // Africel
                                            provider = "AFRICEL";
                                            if (state.field!["phonePayment"].substring(0, 2) =="90") {
                                              // process payment

                                                          TransAcademiaLoadingDialogPhone.show(context);
                                                          int status;
                                                          try {
                                                            var dio = Dio();
                                                            var response = await dio.post(
                                                                "https://api.trans-academia.cd/Trans_Inscription.php",
                                                                data: {
                                                                  "App_name": "app",
                                                                  "token": "2022",
                                                                  "nom": state.field!["nom"],
                                                                  "postnom":
                                                                      state.field!["postnom"],
                                                                  "prenom": state.field!["prenom"],
                                                                  "sexe": state.field!["sexe"],
                                                                  "telephone":
                                                                      "0" + state.field!["phone"],
                                                                  "email": state.field!["email"],
                                                                  "lieuNaissance":
                                                                      state.field!["lieuNaissance"],
                                                                  "avenue": state.field!["avenue"],
                                                                  "numero": state.field!["phone"],
                                                                  "DateNaissance":
                                                                      state.field!["dateNaissance"],
                                                                  "ID_etudiant": state.field!["id"],
                                                                  // "id_promotion":
                                                                  //     state.field!["promotion"],
                                                                  "password":
                                                                      state.field!["password"],
                                                                  "province": state.field!["province"],
                                                                  "commune": state.field!["commune"],
                                                                  "ville": state.field!["ville"],
                                                                });
                                                            var data = response.data;
                                                            print(data);
                                                            status = data['status'];
                                                            // ignore: duplicate_ignore
                                                            if (status == 201) {
                                                              // ignore: use_build_context_synchronously
                                                              TransAcademiaDialogError.show(
                                                                  context,
                                                                  "Vous avez déjà un compte avec ce numéro ",
                                                                  "paiement");
                                                              BlocProvider.of<SignupCubit>(context)
                                                                  .updateField(context,
                                                                      field: "phone",
                                                                      data: state.field!["phone"]);
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds: 4000), () {
                                                                Navigator.of(context)
                                                                    .pushNamedAndRemoveUntil(
                                                                        '/login',
                                                                        (Route<dynamic> route) =>
                                                                            false);
                                                              });
                                                            } else if (status == 200) {
                                                              // upload image

                                                              var request = http.MultipartRequest(
                                                                  'POST',
                                                                  Uri.parse(
                                                                      'https://tag.trans-academia.cd/Trans-upload-image.php'));
                                                              request.fields.addAll({
                                                                'App_name': 'app',
                                                                'token': '2022',
                                                                'id': state.field!['id']
                                                              });
                                                              request.files.add(
                                                                  await http.MultipartFile.fromPath(
                                                                      'photo',
                                                                      state.field!['filePath']));

                                                              http.StreamedResponse response =
                                                                  await request.send();

                                                              if (response.statusCode == 200) {
                                                                // create a prelevement

                                                                int status;
                                                                try {
                                                                  await http.post(
                                                                      Uri.parse(
                                                                          "https://api.trans-academia.cd/Trans_prelevements.php"),
                                                                      body: {
                                                                        'gatewayMode': "1",
                                                                        'IDabonnement': state.field!["abonnement"],
                                                                        // 'amount': state.field![
                                                                        //             "currency"] ==
                                                                        //         "USD"
                                                                        //     ? state
                                                                        //         .field!['prixUSD']
                                                                        //     : state
                                                                        //         .field!['prixCDF'],
                                                                        'currency': state
                                                                            .field!["currency"],
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        "chanel": "MOBILEMONEY",
                                                                        'provider': provider,
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        'walletID': "243" +
                                                                            state.field![
                                                                                "phonePayment"],
                                                                        'IDetudiant':
                                                                            state.field!["id"],
                                                                      }).then((response) async {
                                                                    if (response.statusCode ==
                                                                            500 ||
                                                                        response.statusCode ==
                                                                            504) {
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
                                                                              milliseconds: 3000),
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pushNamedAndRemoveUntil(
                                                                                '/login',
                                                                                (Route<dynamic>
                                                                                        route) =>
                                                                                    false);
                                                                      });
                                                                    } else if (status == 400) {
                                                                      TransAcademiaLoadingDialog
                                                                          .stop(context);
                                                                      TransAcademiaDialogError.show(
                                                                          context,
                                                                          "Erreur de paiement",
                                                                          "prelevement");

                                                                      Future.delayed(
                                                                          const Duration(
                                                                              milliseconds: 3000),
                                                                          () {
                                                                        TransAcademiaDialogError
                                                                            .stop(context);
                                                                      });
                                                                    }
                                                                  });
                                                                } catch (e) {
                                                                  print(e);
                                                                }

                                                                //end prelevement

                                                              } else {
                                                                TransAcademiaLoadingDialogPhone
                                                                    .stop(context);
                                                                TransAcademiaDialogError.show(
                                                                    context,
                                                                    "Erreur de téléchargement pour l'image",
                                                                    "verification");
                                                              }

                                                              // end upload image

                                                              // ignore: use_build_context_synchronously

                                                            } else {
                                                              // ignore: use_build_context_synchronously
                                                              TransAcademiaLoadingDialog.stop(
                                                                  context);
                                                              // ignore: use_build_context_synchronously
                                                              TransAcademiaDialogError.show(
                                                                  context,
                                                                  "Echec d'enregistrement",
                                                                  "verification");

                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds: 4000), () {
                                                                TransAcademiaDialogError.stop(
                                                                    context);
                                                              });
                                                            }
                                                          } catch (e) {
                                                            print(e);
                                                          }


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
