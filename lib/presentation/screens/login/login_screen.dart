// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/home/home_screen.dart';
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
    getDataListAbonnement();
  }

  void getDataListAbonnement() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_Liste_Abonement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);

      dataAbonnement =
          data['donnees'].where((e) => e['Type'] == 'Prelevement').toList();
      prixUSD = dataAbonnement[0]['prix_USD'];

      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "prixCDF", data: dataAbonnement[0]['prix_CDF']);
      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "prixUSD", data: dataAbonnement[0]['prix_USD']);
      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "abonnement", data: dataAbonnement[0]['id']);
    });
  }

  // checkVersion() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String buildNumber = packageInfo.buildNumber;

  //   print('build' + buildNumber);

  //   final response = await http
  //       .get(Uri.parse('https://api-bantou-store.vercel.app/api/v1/versions'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     print(data["android"]);
  //     androidState = data["android"];
  //     iosState = data["ios"];
  //     List<String> descriptionList = data["description"].split(",");

  //     if (Platform.isIOS == true) {
  //       if (int.parse(buildNumber) < int.parse(iosState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/appstore.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion",
  //             data: "Mettez à jour l'application sur Appstore");
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false, arguments: descriptionList);
  //       } else {
  //         return;
  //       }
  //     }

  //     if (Platform.isIOS == false) {
  //       if (int.parse(buildNumber) < int.parse(androidState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/playstore.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion",
  //             data: "Mettez à jour l'application sur playstore");

  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false,arguments: descriptionList);
  //         // return;
  //       } else {
  //         print('ok');
  //       }
  //     }
  //   } else {
  //     print('error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ToastContext().init(context);
    return Scaffold(
      // bottomSheet: SizedBox(
      //   height: 30.0,
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: const [
      //         Text("G.O.D | by Teams Developper"),
      //       ]),
      // ),
      // backgroundColor: Colors.grey.withOpacity(0.1),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                MyColors.mylite,
                MyColors.myBrown
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
                    Container(
                      height: 80,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(
                          AdaptiveTheme.of(context).mode.name != "dark"
                              ? "assets/images/icecream.jpg"
                              : "assets/images/icecream.jpg",
                        ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      height: 5.0,
                    ),

                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                      padding: const EdgeInsets.only(left: 20.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                );
                              }),

                              // onTap: () async {
                              //   if (state.field!["phone"] == "") {
                              //     ValidationDialog.show(context,
                              //         "Veuillez saisir le numéro de téléphone",
                              //         () {
                              //       if (kDebugMode) {
                              //         print("modal");
                              //       }
                              //     });
                              //     return;
                              //   }

                              //   if (state.field!["phone"].substring(0, 1) ==
                              //           "0" ||
                              //       state.field!["phone"].substring(0, 1) ==
                              //           "+") {
                              //     ValidationDialog.show(context,
                              //         "Veuillez saisir le numéro avec le format valide, par exemple: (826016607).",
                              //         () {
                              //       print("modal");
                              //     });
                              //     return;
                              //   }
                              //   if (state.field!["phone"].length < 8) {
                              //     ValidationDialog.show(context,
                              //         "Le numéro ne doit pas avoir moins de 9 caractères, par exemple: (826016607).",
                              //         () {
                              //       print("modal");
                              //     });
                              //     return;
                              //   }
                              //   if (state.field!["password"] == "") {
                              //     ValidationDialog.show(context,
                              //         "le mot de passe ne doit pas être vide",
                              //         () {
                              //       if (kDebugMode) {
                              //         print("modal");
                              //       }
                              //     });
                              //     return;
                              //   }

                              //   // check connexion
                              //   try {
                              //     final response = await InternetAddress.lookup(
                              //         'www.google.com');
                              //     if (response.isNotEmpty) {
                              //       print("connected");
                              //     }
                              //   } on SocketException catch (err) {
                              //     ValidationDialog.show(
                              //         context, "Pas de connexion internet !",
                              //         () {
                              //       if (kDebugMode) {
                              //         print("modal");
                              //       }
                              //     });
                              //     return;
                              //   }

                              //   //send data in api

                              //   TransAcademiaLoadingDialog.show(context);

                              //   int status;
                              //   try {
                              //     await http.post(Uri.parse(
                              //         // "https://tag.trans-academia.cd/Trans_login.php"
                              //         "https://tag.trans-academia.cd/API_login_crypte.php"), body: {
                              //       'App_name': "app",
                              //       'token': "2022",
                              //       // ignore: prefer_interpolation_to_compose_strings
                              //       'login': "0" + state.field!["phone"],
                              //       // 'login': "243827244106",
                              //       'pass': state.field!["password"],
                              //       // 'token': '2022',
                              //       // 'App_name': 'app',
                              //       // 'pass': 'mboso',
                              //       // 'login': '0820000106'
                              //     }).then((response) {
                              //       var data = json.decode(response.body);

                              //       status = data['status'];
                              //       if (status == 201) {
                              //         // if (status == 200) {
                              //         if (data['données'][0]["statut"] ==
                              //             "pending") {
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "phonePayment",
                              //                   data: state.field!["phone"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "id",
                              //                   data: data['données'][0]["id"]);
                              //           TransAcademiaDialogLoginPayment.show(
                              //               context, "Finaliser le Prélèvement",
                              //               () {
                              //             if (kDebugMode) {
                              //               print("modal");
                              //             }
                              //           });
                              //         } else {
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "id",
                              //                   data: data['données'][0]["id"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "phone",
                              //                   data: data['données'][0]
                              //                           ["Login"]
                              //                       .substring(1, 10));
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "password",
                              //                   data: data['données'][0]
                              //                       ["password"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "nom",
                              //                   data: data['données'][0]
                              //                       ["Nom"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "postnom",
                              //                   data: data['données'][0]
                              //                       ["Postnom"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "prenom",
                              //                   data: data['données'][0]
                              //                       ["Prenom"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "codeEtudiant",
                              //                   data: data['données'][0]
                              //                       ["Code Etudiant"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "photo",
                              //                   data: data['données'][0]
                              //                           ["Photo"] ??
                              //                       '');

                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "refresh",
                              //                   data: data['données'][0]
                              //                           ["Refresh"] ??
                              //                       '');

                              //           TransAcademiaLoadingDialog.stop(
                              //               context);
                              //           TransAcademiaDialogSuccess.show(
                              //               context,
                              //               "Authentification réussie",
                              //               "login");
                              //           Future.delayed(
                              //               const Duration(milliseconds: 4000),
                              //               () async {
                              //             SharedPreferences prefs =
                              //                 await SharedPreferences
                              //                     .getInstance();
                              //             prefs.setString(
                              //                 'id', data['données'][0]["id"]);
                              //             prefs.setString(
                              //                 'phone',
                              //                 data['données'][0]["Login"]
                              //                     .substring(1, 10));
                              //             prefs.setString(
                              //                 'nom', data['données'][0]["Nom"]);
                              //             prefs.setString('postnom',
                              //                 data['données'][0]["Postnom"]);
                              //             prefs.setString('prenom',
                              //                 data['données'][0]["Prenom"]);
                              //             prefs.setString(
                              //                 'code',
                              //                 data['données'][0]
                              //                     ["Code Etudiant"]);
                              //             prefs.setString(
                              //                 'photo',
                              //                 data['données'][0]["Photo"] ??
                              //                     '');
                              //             prefs.setString(
                              //                 'refresh',
                              //                 data['données'][0]["Refresh"] ??
                              //                     '');

                              //             // ignore: use_build_context_synchronously
                              //             Navigator.of(context)
                              //                 .pushNamedAndRemoveUntil(
                              //                     '/routestack',
                              //                     (Route<dynamic> route) =>
                              //                         false);
                              //           });
                              //         }
                              //       } else if (status == 200) {
                              //         if (data['données'][0]["statut"] ==
                              //             "pending") {
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "phonePayment",
                              //                   data: state.field!["phone"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "id",
                              //                   data: data['données'][0]["id"]);
                              //           TransAcademiaDialogLoginPayment.show(
                              //               context, "Finaliser le Prélèvement",
                              //               () {
                              //             if (kDebugMode) {
                              //               print("modal");
                              //             }
                              //           });
                              //         } else {
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "id",
                              //                   data: data['données'][0]["id"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "phone",
                              //                   data: data['données'][0]
                              //                           ["Login"]
                              //                       .substring(1, 10));
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "password",
                              //                   data: data['données'][0]
                              //                       ["password"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "nom",
                              //                   data: data['données'][0]
                              //                       ["Nom"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "postnom",
                              //                   data: data['données'][0]
                              //                       ["Postnom"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "prenom",
                              //                   data: data['données'][0]
                              //                       ["Prenom"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "codeEtudiant",
                              //                   data: data['données'][0]
                              //                       ["Code Etudiant"]);
                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "photo",
                              //                   data: data['données'][0]
                              //                           ["Photo"] ??
                              //                       '');

                              //           BlocProvider.of<SignupCubit>(context)
                              //               .updateField(context,
                              //                   field: "refresh",
                              //                   data: data['données'][0]
                              //                           ["Refresh"] ??
                              //                       '');

                              //           TransAcademiaLoadingDialog.stop(
                              //               context);
                              //           TransAcademiaDialogSuccess.show(
                              //               context,
                              //               "Authentification réussie",
                              //               "login");
                              //           Future.delayed(
                              //               const Duration(milliseconds: 4000),
                              //               () async {
                              //             SharedPreferences prefs =
                              //                 await SharedPreferences
                              //                     .getInstance();
                              //             prefs.setString(
                              //                 'id', data['données'][0]["id"]);
                              //             prefs.setString(
                              //                 'phone',
                              //                 data['données'][0]["Login"]
                              //                     .substring(1, 10));
                              //             prefs.setString(
                              //                 'nom', data['données'][0]["Nom"]);
                              //             prefs.setString('postnom',
                              //                 data['données'][0]["Postnom"]);
                              //             prefs.setString('prenom',
                              //                 data['données'][0]["Prenom"]);
                              //             prefs.setString(
                              //                 'code',
                              //                 data['données'][0]
                              //                     ["Code Etudiant"]);
                              //             prefs.setString(
                              //                 'photo',
                              //                 data['données'][0]["Photo"] ??
                              //                     '');
                              //             prefs.setString(
                              //                 'refresh',
                              //                 data['données'][0]["Refresh"] ??
                              //                     '');

                              //             // ignore: use_build_context_synchronously
                              //             Navigator.of(context)
                              //                 .pushNamedAndRemoveUntil(
                              //                     '/routestack',
                              //                     (Route<dynamic> route) =>
                              //                         false);
                              //           });
                              //         }
                              //       } else {
                              //         TransAcademiaLoadingDialog.stop(context);
                              //         TransAcademiaDialogError.show(
                              //             context,
                              //             "Numéro de télépone ou mot de passe incorrect",
                              //             "login");
                              //       }
                              //     });
                              //   } catch (e) {
                              //     print(e);
                              //   }
                              // },

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

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.20,
                    // ),
                    //
                    // Text("A propos",style:GoogleFonts.montserrat(color: Colors.white, fontSize: 12)),
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
