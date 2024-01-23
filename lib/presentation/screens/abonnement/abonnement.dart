// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/dark_theme_styles.dart';
import 'package:icecream_service/presentation/screens/abonnement/widgets/cardPayment.dart';
import 'package:icecream_service/presentation/screens/webView/webviewHome.dart';
import 'package:icecream_service/presentation/widgets/caroussel.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogOTP.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccessAbonnement.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialogPhone.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownPayment.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademiaAbonnement.dart';
import 'package:icecream_service/theme.dart';

import '../../../routestack.dart';
import '../../widgets/inputs/simplePhoneNumberField.dart';
import 'widgets/cardMenu.dart';
import 'widgets/cardNumberCourse.dart';
import 'package:http/http.dart' as http;

class AbonnementScreen extends StatefulWidget {
  bool? backNavigation = false;
  bool? futelanga = false;

  AbonnementScreen(
      {Key? key, required this.backNavigation, required this.futelanga})
      : super(key: key);

  @override
  State<AbonnementScreen> createState() => _AbonnementScreenState();
}

class _AbonnementScreenState extends State<AbonnementScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool selectBank = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool kwendaVutuka = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //state for input select
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  int paymentMethod = 1;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
    BlocProvider.of<AbonnementCubit>(context).initForm();
    // widget.futelanga == true ? getProfilStudentFutelaNga():
    // getProfilStudent();
    if (widget.futelanga == true) {
      getProfilStudentFutelaNga();
    } else {
      getProfilStudent();
    }
  }

  void getDate() async {
    await http
        .get(Uri.parse(
            // "https://api.trans-academia.cd/Trans_countLastCours.php"
            "https://tag.trans-academia.cd/Api_check_day_hours_appmobile.php"))
        .then((response) {
      var data = json.decode(response.body);
      int status;
      print(data['donnees']);
      status = data['status'];
      if (status == 200) {
        BlocProvider.of<SignupCubit>(context).updateField(context,
            field: "day", data: data['donnees'][0]["Day"] ?? "");
        BlocProvider.of<SignupCubit>(context).updateField(context,
            field: "hours", data: data['donnees'][0]["Heure"] ?? "");
        if (data['donnees'][0]["Day"] == "1" ||
            data['donnees'][0]["Heure"] == "21" ||
            data['donnees'][0]["Heure"] == "22" ||
            data['donnees'][0]["Heure"] == "23") {
          BlocProvider.of<AbonnementCubit>(context).updateField(context,
              field: "valueAbonnement", data: "Kwenda vuntuka");
        } else {
          BlocProvider.of<AbonnementCubit>(context)
              .updateField(context, field: "valueAbonnement", data: "");
        }
      } else {
        print('ok');
      }
    });
  }

  // @override
  // void dispose() {
  //   _timer!.cancel();
  //   super.dispose();
  // }

  getProfilStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "currency", data: "");
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context).updateField(context,
        field: "phonePayment", data: prefs.getString('phone'));
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "phone", data: prefs.getString('phone'));
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "id", data: prefs.getString('id'));
  }

  getProfilStudentFutelaNga() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "currency", data: "");
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "phonePayment", data: "");
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "phone", data: "");
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "id", data: prefs.getString('id'));
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        BlocProvider.of<AbonnementCubit>(context).initFormPayment();
        BlocProvider.of<AbonnementCubit>(context).initForm();
      },
      child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(0.1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // brightness: Brightness.light,
            leading: widget.backNavigation == false
                ? null
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AdaptiveTheme.of(context).mode.name != "dark"
                          ? Colors.black
                          : Colors.white,
                    )),
            title: Text(
              widget.futelanga == true
                  ? "Futela nga"
                  : "Merci de sélectionner un moyen de paiement",
              style: TextStyle(
                fontSize: 14,
                color: AdaptiveTheme.of(context).mode.name != "dark"
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Theme.of(context).bottomAppBarColor,
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                // color: Colors.grey.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                // padding: const EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TransAcademiaDropdownPayment(
                      items: "paymentData",
                    ),
                    //select payment
                    const SizedBox(
                      height: 40.0,
                    ),
                    BlocBuilder<AbonnementCubit, AbonnementState>(
                      builder: (context, state) {
                        return const TransAcademiaDropdownAbonnement(
                          items: "abonnementData",
                          value: "abonnement",
                          label: "Type d'abonnement",
                          hintText: "Type d'abonnement",
                        );
                      },
                    ),

                    widget.futelanga == false
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10),
                            child: Row(
                              children: const [
                                Text(
                                  "Veuillez renseigner le numéro du sponsor",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),

                    paymentMethod == 1 || paymentMethod == 2
                        ? Column(
                            children: [
                              BlocBuilder<SignupCubit, SignupState>(
                                  builder: (context, state) {
                                return state.field!["inputVisible"] == "true"
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 20),
                                        child: SizedBox(
                                          height: 50.0,
                                          child: TransAcademiaPhoneNumber(
                                            number: 20,
                                            controller: phoneController,
                                            hintText: "Numéro de téléphone",
                                            field: "phonePayment",
                                            fieldValue: state.field!["phone"],
                                          ),
                                        ))
                                    : Container();
                              }),
                              const SizedBox(
                                height: 20.0,
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
                                                state.field!["currency"] ==
                                                        "USD"
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
                                                state.field!["currency"] ==
                                                        "CDF"
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
                                height: 30.0,
                              ),
                              BlocBuilder<AbonnementCubit, AbonnementState>(
                                builder: (context, stateAbonnement) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BlocBuilder<SignupCubit, SignupState>(
                                          builder: (context, state) {
                                            return GestureDetector(
                                              onTap: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var provider;
                                                print(state
                                                    .field!["disponibility"]);
                                                if (state.field![
                                                        "disponibility"] ==
                                                    "N") {
                                                  // provider == "EQUITYBCDC";
                                                  ValidationDialog.show(context,
                                                      "Cher ${state.field!["prenom"]},\n\nCe moyen de paiement est indisponible pour l'instant, nous travaillons sur son retablissement. Nous vous prions d'en choisir un autre.\n\nMerci",
                                                      () {
                                                    print("modal");
                                                  });
                                                  return;
                                                }
                                                if (state.field![
                                                        "typePaymentFromApi"] ==
                                                    "") {
                                                  ValidationDialog.show(context,
                                                      "Veuillez choisir le moyen de paiement",
                                                      () {
                                                    print("modal");
                                                  });
                                                  return;
                                                }
                                                if (stateAbonnement
                                                        .field!["abonnement"] ==
                                                    "") {
                                                  ValidationDialog.show(context,
                                                      "Veuillez choisir le type d'abonnement",
                                                      () {
                                                    print("modal");
                                                  });
                                                  return;
                                                }

                                                if (state.field!["currency"] ==
                                                    "") {
                                                  ValidationDialog.show(context,
                                                      "Veuillez choisir la devise",
                                                      () {
                                                    print("modal");
                                                  });
                                                  return;
                                                }

                                                if (state.field![
                                                        "phonePayment"] ==
                                                    "") {
                                                  ValidationDialog.show(context,
                                                      "le numéro ne doit pas être vide",
                                                      () {
                                                    print("modal");
                                                  });
                                                  return;
                                                }

                                                if (state.field!["phonePayment"]
                                                        .length <
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

                                                if ((stateAbonnement.field![
                                                            "abonnement"] ==
                                                        "13" &&
                                                    kwendaVutuka == false)) {
                                                  setState(() {
                                                    kwendaVutuka = true;
                                                  });
                                                  ValidationDialog.show(context,
                                                      "Vous êtes  sur le point d'activer un abonnement dont l'expiration est aujourd’hui à  23:59:59 cher(e) ${state.field!["prenom"]}.",
                                                      () {
                                                    print("modal");
                                                  });
                                                  return;
                                                }

                                                // check connexion
                                                try {
                                                  final response =
                                                      await InternetAddress
                                                          .lookup(
                                                              'www.google.com');
                                                  if (response.isNotEmpty) {
                                                    if (kDebugMode) {
                                                      print("connected");
                                                    }
                                                  }
                                                } on SocketException catch (err) {
                                                  ValidationDialog.show(context,
                                                      "Pas de connexion internet !",
                                                      () {
                                                    if (kDebugMode) {
                                                      print("modal");
                                                    }
                                                  });
                                                  return;
                                                }

                                                //send data in api

                                                // new code

                                                if (state.field![
                                                        "typePaymentFromApi"] ==
                                                    "MPESA") {
                                                  // MPESA
                                                  provider = "MPESA";
                                                  if (state.field!["phonePayment"].substring(0, 2) == "81" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "82" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "83") {
                                                    // process payment
                                                    TransAcademiaLoadingDialogPhone
                                                        .show(context);
                                                    // abonnement

                                                    int status;
                                                    String? msg;
                                                    try {
                                                      await http.post(
                                                          Uri.parse(
                                                              "https://tag.trans-academia.cd/Api_abonnement.php"),
                                                          body: {
                                                            'currency':
                                                                state.field![
                                                                    "currency"],
                                                            'provider':
                                                                provider,
                                                            'walletID': "243" +
                                                                state.field![
                                                                    "phonePayment"],
                                                            'etudiantID':
                                                                prefs.getString(
                                                                    'code'),
                                                            'abonnementID':
                                                                stateAbonnement
                                                                        .field![
                                                                    "abonnement"],
                                                          }).then(
                                                          (response) async {
                                                        if (response.statusCode == 500 ||
                                                            response.statusCode ==
                                                                504 ||
                                                            response.statusCode ==
                                                                502) {
                                                          TransAcademiaLoadingDialog
                                                              .stop(context);
                                                          TransAcademiaDialogError.show(
                                                              context,
                                                              "Erreur de paiement",
                                                              "verification");
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            return;
                                                            // TransAcademiaDialogError.stop(
                                                            //     context);
                                                          });
                                                        }

                                                        var data = json.decode(
                                                            response.body);

                                                        status = data['status'];
                                                        msg = data['msg'];
                                                        if (status == 201) {
                                                          // print("top");
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
                                                        } else if (status ==
                                                            400) {
                                                          TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogError
                                                              .show(
                                                                  context,
                                                                  "Erreur de paiement",
                                                                  "prelevement");

                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            TransAcademiaDialogError
                                                                .stop(context);
                                                          });
                                                        }
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    // fin abonnement

                                                    // fin process payment
                                                  } else {
                                                    // ignore: use_build_context_synchronously
                                                    ValidationDialog.show(
                                                        context,
                                                        "Veuillez saisir un numéro Vodacom valide, par exemple: (826016607)",
                                                        () {
                                                      if (kDebugMode) {
                                                        print("modal");
                                                      }
                                                    });
                                                    return;
                                                  }
                                                } else if (state.field![
                                                        "typePaymentFromApi"] ==
                                                    "ORANGE") {
                                                  // ORANGE
                                                  provider = "ORANGE";
                                                  if (state.field!["phonePayment"].substring(0, 2) == "89" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "85" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "84" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "80") {
                                                    // process payment
                                                    TransAcademiaLoadingDialogPhone
                                                        .show(context);
                                                    // abonnement

                                                    int status;
                                                    String? msg;
                                                    try {
                                                      await http.post(
                                                          Uri.parse(
                                                              "https://tag.trans-academia.cd/Api_abonnement.php"),
                                                          body: {
                                                            'currency':
                                                                state.field![
                                                                    "currency"],
                                                            'provider':
                                                                provider,
                                                            'walletID': "0" +
                                                                state.field![
                                                                    "phonePayment"],
                                                            'etudiantID':
                                                                prefs.getString(
                                                                    'code'),
                                                            'abonnementID':
                                                                stateAbonnement
                                                                        .field![
                                                                    "abonnement"],
                                                          }).then(
                                                          (response) async {
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
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            return;
                                                            // TransAcademiaDialogError.stop(
                                                            //     context);
                                                          });
                                                        }

                                                        var data = json.decode(
                                                            response.body);
                                                        msg = data['msg'];
                                                        status = data['status'];
                                                        if (status == 200) {
                                                          // print("top");
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
                                                                      3000),
                                                              () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                                    '/routestack',
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                          });
                                                        } else if (status ==
                                                            400) {
                                                          TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogError
                                                              .show(
                                                                  context,
                                                                  "Erreur de paiement",
                                                                  "prelevement");

                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            TransAcademiaDialogError
                                                                .stop(context);
                                                          });
                                                        }
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }

                                                    // fin abonnement

                                                  } else {
                                                    // ignore: use_build_context_synchronously
                                                    ValidationDialog.show(
                                                        context,
                                                        "Veuillez saisir un numéro Orange valide, par exemple: (896016607)",
                                                        () {
                                                      if (kDebugMode) {
                                                        print("modal");
                                                      }
                                                    });
                                                    return;
                                                  }
                                                } else if (state.field![
                                                        "typePaymentFromApi"] ==
                                                    "AIRTEL") {
                                                  // Airtel
                                                  provider = "AIRTEL";
                                                  if (state.field!["phonePayment"].substring(0, 2) == "99" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "98" ||
                                                      state.field![
                                                                  "phonePayment"]
                                                              .substring(
                                                                  0, 2) ==
                                                          "97") {
                                                    // process payment

                                                    // ignore: use_build_context_synchronously
                                                    TransAcademiaLoadingDialogPhone
                                                        .show(context);
                                                    // abonnement

                                                    int status;
                                                    try {
                                                      await http.post(
                                                          Uri.parse(
                                                              "https://tag.trans-academia.cd/Api_abonnement.php"),
                                                          body: {
                                                            'currency':
                                                                state.field![
                                                                    "currency"],
                                                            'provider':
                                                                provider,
                                                            'walletID':
                                                                state.field![
                                                                    "phonePayment"],
                                                            'etudiantID':
                                                                prefs.getString(
                                                                    'code'),
                                                            'abonnementID':
                                                                stateAbonnement
                                                                        .field![
                                                                    "abonnement"],
                                                          }).then(
                                                          (response) async {
                                                        if (response.statusCode ==
                                                                500 ||
                                                            response.statusCode ==
                                                                504) {
                                                          TransAcademiaLoadingDialog
                                                              .stop(context);
                                                          TransAcademiaDialogError.show(
                                                              context,
                                                              "Erreur de paiement",
                                                              "verification");
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            return;
                                                            // TransAcademiaDialogError.stop(
                                                            //     context);
                                                          });
                                                        }

                                                        var data = json.decode(
                                                            response.body);

                                                        status = data['status'];
                                                        if (status == 200) {
                                                          // print("top");
                                                          TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogSuccess
                                                              .show(
                                                                  context,
                                                                  "votre transaction à été traité avec succès",
                                                                  "paiement");
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                                    '/routestack',
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                          });
                                                        } else if (status ==
                                                            400) {
                                                          TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogError
                                                              .show(
                                                                  context,
                                                                  "Erreur de paiement",
                                                                  "prelevement");

                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            TransAcademiaDialogError
                                                                .stop(context);
                                                          });
                                                        }
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    // fin abonnement

                                                  } else {
                                                    // ignore: use_build_context_synchronously
                                                    ValidationDialog.show(
                                                        context,
                                                        "Veuillez saisir un numéro Airtel valide, par exemple: (996016607)",
                                                        () {
                                                      if (kDebugMode) {
                                                        print("modal");
                                                      }
                                                    });
                                                    return;
                                                  }
                                                } else if (state.field![
                                                        "typePaymentFromApi"] ==
                                                    "RAKKA") {
                                                  // Airtel
                                                  provider = "RAKKA";

                                                  // process payment
                                                  TransAcademiaLoadingDialogPhone
                                                      .show(context);
                                                  // abonnement

                                                  int status;
                                                  String? msg, codetransaction;
                                                  try {
                                                    await http.post(
                                                        Uri.parse(
                                                            "https://tag.trans-academia.cd/abonnement_raka.php"),
                                                        body: {
                                                          'currency':
                                                              state.field![
                                                                  "currency"],
                                                          'provider': provider,
                                                          'walletID': "243" +
                                                              state.field![
                                                                  "phonePayment"],
                                                          'etudiantID':
                                                              prefs.getString(
                                                                  'code'),
                                                          'abonnementID':
                                                              stateAbonnement
                                                                      .field![
                                                                  "abonnement"],
                                                        }).then(
                                                        (response) async {
                                                      if (response.statusCode == 500 ||
                                                          response.statusCode ==
                                                              504 ||
                                                          response.statusCode ==
                                                              502) {
                                                        TransAcademiaLoadingDialog
                                                            .stop(context);
                                                        TransAcademiaDialogError
                                                            .show(
                                                                context,
                                                                "Erreur de paiement",
                                                                "verification");
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    3000), () {
                                                          return;
                                                          // TransAcademiaDialogError.stop(
                                                          //     context);
                                                        });
                                                      }

                                                      int startIndex = response
                                                          .body
                                                          .indexOf('{');
                                                      print(response.body);

                                                      String jsonPart = response
                                                          .body
                                                          .substring(
                                                              startIndex);

                                                      var data =
                                                          json.decode(jsonPart);

                                                      status = data['status'];
                                                      msg = data['msg'];
                                                      codetransaction = data[
                                                          'codetransaction'];

                                                      if (status == 200) {
                                                        // print("top");
                                                        TransAcademiaLoadingDialogPhone
                                                            .stop(context);
                                                        BlocProvider.of<
                                                                    SignupCubit>(
                                                                context)
                                                            .updateField(
                                                                context,
                                                                field:
                                                                    "codetransaction",
                                                                data:
                                                                    codetransaction);
                                                        TransAcademiaDialogOTP
                                                            .show(context);
                                                      } else if (status ==
                                                          400) {
                                                        TransAcademiaLoadingDialogPhone
                                                            .stop(context);
                                                        TransAcademiaDialogError
                                                            .show(context, msg,
                                                                "prelevement");

                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    3000), () {
                                                          TransAcademiaDialogError
                                                              .stop(context);
                                                        });
                                                      } else {
                                                        TransAcademiaLoadingDialogPhone
                                                            .stop(context);
                                                        TransAcademiaDialogError
                                                            .show(context, msg,
                                                                "prelevement");

                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    3000), () {
                                                          TransAcademiaDialogError
                                                              .stop(context);
                                                        });
                                                      }
                                                    });
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  // fin abonnement

                                                  // showToast("Bientôt disponible",
                                                  //     duration: 3,
                                                  //     gravity: Toast.bottom);
                                                  // return;
                                                  // Navigator.of(context).pop();

                                                } else if (state.field![
                                                        "typePaymentFromApi"] ==
                                                    "PEPELEMOBILE") {
                                                  var prixUSDFirst =
                                                      double.parse(state.field![
                                                              "prixUSD"]) *
                                                          100;

                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WebViewApp(
                                                              amount: state.field![
                                                                          "currency"] ==
                                                                      "CDF"
                                                                  ? state.field![
                                                                      "prixCDF"]
                                                                  : prixUSDFirst
                                                                      .toStringAsFixed(
                                                                          2),
                                                              currency: state
                                                                      .field![
                                                                  "currency"],
                                                              phonenumber: "243" +
                                                                  state.field![
                                                                      "phone"],
                                                            )),
                                                  );
                                                } else {
                                                  // Africel
                                                  provider = "AFRICEL";
                                                  if (state.field![
                                                              "phonePayment"]
                                                          .substring(0, 2) ==
                                                      "90") {
                                                    // process payment
                                                    // ignore: use_build_context_synchronously
                                                    TransAcademiaLoadingDialogPhone
                                                        .show(context);
                                                    // abonnement

                                                    int status;
                                                    try {
                                                      await http.post(
                                                          Uri.parse(
                                                              "https://api.trans-academia.cd/Trans_academia_abonnement.php"),
                                                          body: {
                                                            'gatewayMode': "1",
                                                            'currency':
                                                                state.field![
                                                                    "currency"],
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "chanel":
                                                                "MOBILEMONEY",
                                                            'provider':
                                                                provider,
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            'walletID': "+243" +
                                                                state.field![
                                                                    "phonePayment"],
                                                            'IDetudiant': state
                                                                .field!["id"],
                                                            'IDabonnement':
                                                                stateAbonnement
                                                                        .field![
                                                                    "abonnement"],
                                                          }).then(
                                                          (response) async {
                                                        if (response.statusCode ==
                                                                500 ||
                                                            response.statusCode ==
                                                                504) {
                                                          TransAcademiaLoadingDialog
                                                              .stop(context);
                                                          TransAcademiaDialogError.show(
                                                              context,
                                                              "Erreur de paiement",
                                                              "verification");
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            return;
                                                            // TransAcademiaDialogError.stop(
                                                            //     context);
                                                          });
                                                        }

                                                        var data = json.decode(
                                                            response.body);

                                                        status = data['status'];
                                                        if (status == 200) {
                                                          // print("top");
                                                          TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogSuccess
                                                              .show(
                                                                  context,
                                                                  "votre transaction à été traité avec succès",
                                                                  "paiement");
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamedAndRemoveUntil(
                                                                    '/routestack',
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                          });
                                                        } else if (status ==
                                                            400) {
                                                          TransAcademiaLoadingDialogPhone
                                                              .stop(context);
                                                          TransAcademiaDialogError
                                                              .show(
                                                                  context,
                                                                  "Erreur de paiement",
                                                                  "prelevement");

                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      3000),
                                                              () {
                                                            TransAcademiaDialogError
                                                                .stop(context);
                                                          });
                                                        }
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }

                                                    // fin abonnement

                                                  } else if (state.field![
                                                              "phonePayment"]
                                                          .substring(0, 2) ==
                                                      "90") {
                                                    // ignore: use_build_context_synchronously
                                                    ValidationDialog.show(
                                                        context,
                                                        "Veuillez saisir un numéro Africel valide, par exemple: (906016607)",
                                                        () {
                                                      if (kDebugMode) {
                                                        print("modal");
                                                      }
                                                    });
                                                    return;
                                                  }
                                                }

                                                // fin new code

                                                // // ignore: unrelated_type_equality_checks
                                                // if (paymentMethod == 1) {
                                                //   print('voda');

                                                //   // if (state.field!["currency"] == "") {
                                                //   //   ValidationDialog.show(context,
                                                //   //       "Veuillez choisir la devise",
                                                //   //       () {
                                                //   //     print("modal");
                                                //   //   });
                                                //   //   return;
                                                //   // }

                                                //   // if (state.field!["phone"] == "") {
                                                //   //   ValidationDialog.show(context,
                                                //   //       "le numéro ne doit pas être vide",
                                                //   //       () {
                                                //   //     print("modal");
                                                //   //   });
                                                //   //   return;
                                                //   // }

                                                //   // if (state.field!["phone"].length <
                                                //   //     9) {
                                                //   //   ValidationDialog.show(context,
                                                //   //       "Le numéro de paiement ne doit pas avoir moins de 9 chiffres",
                                                //   //       () {
                                                //   //     if (kDebugMode) {
                                                //   //       print("modal");
                                                //   //     }
                                                //   //   });
                                                //   //   return;
                                                //   // }

                                                //   //send data in api
                                                //   // ignore: unused_local_variable
                                                //   var provider;

                                                //   // if (!checkLengthNumber.hasMatch(state.field!["phonePayment"])) {
                                                //   //   ValidationDialog.show(context,
                                                //   //       "Veuillez inseré un numero avec 9 chiffres.",
                                                //   //       () {
                                                //   //     print("modal");
                                                //   //     return;
                                                //   //   });
                                                //   // }

                                                //   if (state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "81" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "82" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "83") {
                                                //     provider = "MPESA";
                                                //   } else if (state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "89" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "85" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "84" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "80") {
                                                //     provider = "ORANGE";
                                                //   } else if (state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "99" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "98" ||
                                                //       state.field!["phone"]
                                                //               .substring(0, 2) ==
                                                //           "97") {
                                                //     provider = "AIRTEL";
                                                //   } else {
                                                //     provider = "AFRICEL";
                                                //   }
                                                //   // startTimer();
                                                //   TransAcademiaLoadingDialogPhone.show(
                                                //       context);

                                                //   int status;
                                                //   try {
                                                //     await http.post(
                                                //         Uri.parse(
                                                //             "https://api.trans-academia.cd/Trans_academia_abonnement.php"),
                                                //         body: {
                                                //           'gatewayMode': "1",
                                                //           'currency':
                                                //               state.field!["currency"],
                                                //           // ignore: prefer_interpolation_to_compose_strings
                                                //           "chanel": "MOBILEMONEY",
                                                //           'provider': provider,
                                                //           // ignore: prefer_interpolation_to_compose_strings
                                                //           'walletID': "+243" +
                                                //               state.field!["phone"],
                                                //           'IDetudiant':
                                                //               state.field!["id"],
                                                //           'IDabonnement':
                                                //               stateAbonnement
                                                //                   .field!["abonnement"],
                                                //         }).then((response) async {
                                                //       if (response.statusCode == 500 ||
                                                //           response.statusCode == 504) {
                                                //         TransAcademiaLoadingDialog.stop(
                                                //             context);
                                                //         TransAcademiaDialogError.show(
                                                //             context,
                                                //             "Erreur de paiement",
                                                //             "verification");
                                                //         Future.delayed(
                                                //             const Duration(
                                                //                 milliseconds: 3000),
                                                //             () {
                                                //           return;
                                                //           // TransAcademiaDialogError.stop(
                                                //           //     context);
                                                //         });
                                                //       }

                                                //       var data =
                                                //           json.decode(response.body);

                                                //       status = data['status'];
                                                //       if (status == 200) {
                                                //         // print("top");
                                                //         TransAcademiaLoadingDialogPhone
                                                //             .stop(context);
                                                //         TransAcademiaDialogSuccess.show(
                                                //             context,
                                                //             "votre transaction à été traité avec succès",
                                                //             "paiement");
                                                //         Future.delayed(
                                                //             const Duration(
                                                //                 milliseconds: 3000),
                                                //             () {
                                                //           Navigator.of(context)
                                                //               .pushNamedAndRemoveUntil(
                                                //                   '/routestack',
                                                //                   (Route<dynamic>
                                                //                           route) =>
                                                //                       false);
                                                //         });
                                                //       } else if (status == 400) {
                                                //         TransAcademiaLoadingDialogPhone
                                                //             .stop(context);
                                                //         TransAcademiaDialogError.show(
                                                //             context,
                                                //             "Erreur de paiement",
                                                //             "prelevement");

                                                //         Future.delayed(
                                                //             const Duration(
                                                //                 milliseconds: 3000),
                                                //             () {
                                                //           TransAcademiaDialogError.stop(
                                                //               context);
                                                //         });
                                                //       }
                                                //     });
                                                //   } catch (e) {
                                                //     print(e);
                                                //   }
                                                // } else {
                                                //   TransAcademiaDialogOTP.show(context);
                                                // }
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const RouteStack()),
                                                // );
                                              },
                                              child: Container(
                                                height: 50.0,
                                                // width: MediaQuery.of(context).size.width * 0.80,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color(0xff129BFF),
                                                      kelasiColor,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Payer",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : const Expanded(child: CardPayment())

                    // Bank Payment
                    // selectBank == true ? Expanded(child: CardPayment()) : Container()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Container(
          child: Row(
            children: [
              logoContainer("assets/images/vodacom.webp"),
              logoContainer("assets/images/orange.webp"),
              logoContainer("assets/images/airtel.webp"),
              logoContainer("assets/images/afrimoney.webp"),
            ],
          ),
        ),
        value: "1"),
    DropdownMenuItem(
        child: Container(
          child: Row(
            children: [
              logoContainer("assets/images/logo-illico.webp"),
              const SizedBox(
                width: 20.0,
              ),
              const Text("Illicocash")
            ],
          ),
        ),
        value: "2"),
    DropdownMenuItem(
        child: Container(
          child: Row(
            children: [
              logoContainer("assets/images/visa.webp"),
              logoContainer("assets/images/mastercard.webp"),
              const SizedBox(
                width: 20.0,
              ),
              const Text("Visa ou Mastercard")
            ],
          ),
        ),
        value: "3"),
  ];
  return menuItems;
}

Container logoContainer(logo) {
  return Container(
    height: 50,
    width: 50,
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(color: Colors.blueAccent, width: 1),
      image: DecorationImage(
          fit: BoxFit.cover, image: AssetImage(logo.toString())),
    ),
  );
}
