import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/home/home_screen.dart';
import 'package:icecream_service/presentation/screens/signup/signup-personnel-step1.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step1.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step3.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaYesNoDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
// ignore: unused_import
import 'package:icecream_service/locale/all_translations.dart';
import 'package:icecream_service/presentation/widgets/inputs/dateField.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownCommune.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/routestack.dart';
// import 'package:icecream_service/models/base.model.dart';
// import 'package:icecream_service/screens/home/home.dart';
// import 'package:icecream_service/screens/signup/signup1.dart';
// import 'package:icecream_service/services/http/user.service.dart';
import 'package:icecream_service/sizeconfig.dart';
import 'package:icecream_service/theme.dart';
import 'package:icecream_service/presentation/widgets/inputs/passwordTextField.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/presentation/widgets/inputs/passwordTextField.dart';
import 'package:icecream_service/theme.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SignupStep2 extends StatefulWidget {
  const SignupStep2({Key? key, this.isStudentPage}) : super(key: key);
  final bool? isStudentPage;

  @override
  // ignore: library_private_types_in_public_api
  _SignupStep2State createState() => _SignupStep2State();
}

class _SignupStep2State extends State<SignupStep2>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool status = false;
  TextEditingController lieuNaissanceController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController communeControllerController = TextEditingController();
  TextEditingController quartierController = TextEditingController();
  TextEditingController avenueController = TextEditingController();
  TextEditingController numeroAdresseController = TextEditingController();
  String? sexe = "homme";

  String? nameError;
  String? passwordError;
  String? submitError;
  bool checked = false;
  bool isWoman = false;
  var communes = [];
  var provinces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataCommunes();
    getDataProvinces();
    BlocProvider.of<SignupCubit>(context).initFormProvince();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
  }

  String stateInfoUrl = 'https://api.trans-academia.cd/';
  void getDataCommunes() async {
    await http.post(Uri.parse("${stateInfoUrl}listeCommune.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        communes = data['donnees'];
      });

      communes;
    });
  }

  void getDataProvinces() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_liste_Province.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        provinces = data['donnees'];
      });

      provinces;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
              
                  const SizedBox(
                    height: 30.0,
                  ),
                  const TransAcademiaDropdownSexe(
                    value: "sexe",
                    label: "Choisir le sexe",
                    hintText: "choisir Province",
                  ),
                  const TransAcademiaDropdown(
                    items: "provinceData",
                    value: "province",
                    label: "Choisir la province",
                    hintText: "choisir Province",
                  ),
                  const TransAcademiaDropdown(
                    items: "villeData",
                    value: "ville",
                    label: "Choisir la ville",
                    hintText: "Choisir la faculté",
                  ),
                  const TransAcademiaDropdown(
                    items: "communeData",
                    value: "commune",
                    label: "Choisir la commune",
                    hintText: "choisir la commune",
                  ),
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            height: 50.0,
                            child: TransAcademiaNameInput(
                              controller: quartierController,
                              hintText: "Quartier",
                              color: Colors.white,
                              label: "Quartier",
                              field: "quartier",
                              fieldValue: state.field!["quartier"],
                            ),
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
                              controller: avenueController,
                              hintText: "Avenue",
                              color: Colors.white,
                              label: "Avenue",
                              field: "avenue",
                              fieldValue: state.field!["avenue"],
                            ),
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
                              controller: numeroAdresseController,
                              hintText: "Numéro d'adresse",
                              color: Colors.white,
                              label: "Numéro d'adresse",
                              field: "numeroAdresse",
                              fieldValue: state.field!["numeroAdresse"],
                            ),
                          ));
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                        color: Colors.black26,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      StepIndicatorWidget(
                        color: Colors.blueAccent,
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
                                '/signupStep1',
                                (Route<dynamic> route) => false);
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
                                if (state.field!["province"] == "") {
                                  ValidationDialog.show(context,
                                      "Veuillez sélectionner la province", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["ville"] == "") {
                                  ValidationDialog.show(
                                      context, "Veuillez sélectionner la ville",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["quartier"] == "") {
                                  ValidationDialog.show(context,
                                      "le quartier ne doit pas être vide", () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["avenue"] == "") {
                                  ValidationDialog.show(
                                      context, "l'avenue ne doit pas être vide",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }
                                if (state.field!["numeroAdresse"] == "") {
                                  ValidationDialog.show(context,
                                      "le numéro d'adresse ne doit pas être vide",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                // if (state.field!["sexe"] == "F") {

                                // } else {
                                //   TransAcademiaYesNoDialog.show(context,
                                //       "êtes-vous réellement un homme ? Sinon veuillez cliquez sur Femme");
                                // }

                                //send data in api
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                // send
                                // process payment
                                TransAcademiaLoadingDialog.show(context);
                                int status;
                                try {
                                  var dio = Dio();
                                  var response = await dio.post(
                                      "https://tag.trans-academia.cd/API_UpdateInscription.php",
                                      data: {
                                        // "App_name": "app",
                                        // "token": "2022",
                                        // "nom": state.field!["nom"],
                                        // "postnom":
                                        //     state.field!["postnom"],
                                        // "prenom": state.field!["prenom"],
                                        // "sexe": state.field!["sexe"],
                                        // "telephone":
                                        //     "0" + state.field!["phone"],
                                        // "email": state.field!["email"],
                                        // "lieuNaissance":
                                        //     state.field!["lieuNaissance"],
                                        // "avenue": state.field!["avenue"],
                                        // "numero": state.field!["phone"],
                                        // "DateNaissance":
                                        //     state.field!["dateNaissance"],
                                        // "ID_etudiant": state.field!["id"],
                                        // // "id_promotion":
                                        // //     state.field!["promotion"],
                                        // "password":
                                        //     state.field!["password"],
                                        // "province":
                                        //     state.field!["province"],
                                        // "commune":
                                        //     state.field!["commune"],
                                        // "ville":
                                        //     state.field!["ville"],
                                        "token": "2022",
                                        "token": "2022",
                                        "App_name": "app",
                                        "faculte": state.field!["faculte"],
                                        "departement":
                                            state.field!["departement"],
                                        "promotion": state.field!["promotion"],
                                        "sexe": state.field!["sexe"],
                                        "telephone":
                                            "0${state.field!["phone"]}",
                                        "ID_etudiant": state.field!["sexe"],
                                        "generate_tac": prefs.getString('code'),
                                        "email": state.field!["email"],
                                        "lieuNaissance":
                                            state.field!["lieuNaissance"],
                                        "avenue": state.field!["avenue"],
                                        "numero": state.field!["numeroAdresse"],
                                        "DateNaissance":
                                            state.field!["dateNaissance"],
                                        "password": state.field!["password"],
                                        "province": state.field!["province"],
                                        "commune": state.field!["commune"],
                                        "ville": state.field!["ville"]
                                      });
                                  var data = response.data;
                                  print(data);
                                  status = data['status'];
                                  // ignore: duplicate_ignore
                                  if (status == 200) {
                                    TransAcademiaLoadingDialog.stop(context);
                                    TransAcademiaDialogSuccess.show(context,
                                        "Modification réussie", "login");
                                    Future.delayed(
                                        const Duration(milliseconds: 4000),
                                        () async {
                                        prefs.clear();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/login',
                                              (Route<dynamic> route) => false);
                                    });
                                  } else {
                                    TransAcademiaLoadingDialog.stop(context);
                                    TransAcademiaDialogError.show(context,
                                        "Erreur d'enregistrement", "login");
                                  }

                                  // end upload image

                                  // ignore: use_build_context_synchronously

                                } catch (e) {
                                  print(e);
                                }

                                // end

                                // TransAcademiaLoadingDialog.show(context);

                                // int status;
                                // try {
                                //   await http.post(
                                //       Uri.parse(
                                //         // "https://tag.trans-academia.cd/Trans_login.php"

                                //         "https://tag.trans-academia.cd/API_UpdateInscription.php"
                                //         ),
                                //       body: {
                                //           // "token": "2022",
                                //           // "App_name": "app",
                                //           // "faculte": state.field!["faculte"],
                                //           // "departement": state.field!["departement"],
                                //           // "promotion": state.field!["promotion"],
                                //           // "sexe": state.field!["sexe"],
                                //           // "telephone": "0${state.field!["phone"]}",
                                //           // "ID_etudiant": prefs.getString('id'),
                                //           // "generate_tac": prefs.getString('code'),
                                //           // "email": "tech@trans-academia.cd",
                                //           // "lieuNaissance": state.field!["lieuNaissance"],
                                //           // "avenue": state.field!["avenue"],
                                //           // "numero": state.field!["numero"],
                                //           // "DateNaissance": state.field!["DateNaissance"],
                                //           // "password": state.field!["password"],
                                //           // "province":state.field!["province"],
                                //           // "commune": state.field!["commune"],
                                //           // "ville": state.field!["ville"]
                                //     "token":"2022",
                                //     "App_name":"app",
                                //     "faculte":"300",
                                //     "departement":"300",
                                //     "promotion":"300",
                                //     "sexe":"m",
                                //     "telephone":"0820000106",
                                //     "ID_etudiant":"2",
                                //     "generate_tac":"STDTAC202304040101DFYTAS360567",
                                //     "email":"mboso@gmail.com",
                                //     "lieuNaissance":"kikwiti",
                                //     "avenue":"kitona",
                                //     "numero":"106",
                                //     "DateNaissance":"1960-02-19",
                                //     "password":"mboso",
                                //     "province":"2",
                                //     "commune":"2",
                                //     "ville":"1"
                                //       }).then((response) {
                                //     var data = json.decode(response.body);

                                //     status = data['status'];
                                //     if (status == 200) {
                                //         TransAcademiaLoadingDialog.stop(context);
                                //         TransAcademiaDialogSuccess.show(context,
                                //             "Modification réussie", "login");
                                //         Future.delayed(
                                //             const Duration(milliseconds: 4000),
                                //             () async {
                                //           // ignore: use_build_context_synchronously
                                //           Navigator.of(context)
                                //               .pushNamedAndRemoveUntil('/routestack',
                                //                   (Route<dynamic> route) => false);
                                //         });
                                //     } else {
                                //       TransAcademiaLoadingDialog.stop(context);
                                //       TransAcademiaDialogError.show(
                                //           context,
                                //           "Erreur d'enregistrement",
                                //           "login");
                                //     }
                                //   });
                                // } catch (e) {
                                //   print(e);
                                // }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const SignupStep3()),
                                // );
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
                          },
                        ),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
