import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/data/models/abonnement.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step2.dart';
import 'package:icecream_service/presentation/screens/signup/signup.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
// ignore: unused_import
import 'package:icecream_service/locale/all_translations.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/sizeconfig.dart';
import 'package:icecream_service/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPersonnelStep1 extends StatefulWidget {
  const SignupPersonnelStep1({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupPersonnelStep1State createState() => _SignupPersonnelStep1State();
}

class _SignupPersonnelStep1State extends State<SignupPersonnelStep1> {
  TextEditingController nomController = TextEditingController();
  TextEditingController postnomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController universiteController = TextEditingController();
  TextEditingController faculteController = TextEditingController();
  TextEditingController departementController = TextEditingController();
  TextEditingController promotionController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;
  bool checked = false;
  var etablissements = [];
  var facultes = [];
  var depaterments = [];
  var promotions = [];
  // var abonnements = [];
  late List<Abonnement> allAbonnements;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignupCubit>(context).initForm();
    // getDataEtablisement();
    // getDataFacultes();
    // getDataDepartements();
    // getDataPromo();
  }

  String stateInfoUrl = 'https://api.trans-academia.cd/';
  void getDataEtablisement() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_liste_Etablisement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);
      etablissements = data['donnees'];

      etablissements;
    });
  }

  void getDataFacultes() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_liste_Facultes.php"),
        body: {'App_name': "app", 'token': "2022", 'id': "1"}).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        facultes = data['donnees'];
      });

      facultes;
    });
  }

  void getDataDepartements() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_liste_Departement.php"),
        body: {'App_name': "app", 'token': "2022", 'id': "1"}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        depaterments = data['donnees'];
      });

      depaterments;
    });
  }

  void getDataPromo() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_liste_promotion.php"),
        body: {'App_name': "app", 'token': "2022", 'id': "1"}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        promotions = data['donnees'];
      });

      promotions;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // color: Colors.grey.withOpacity(0.1),
                // color: Colors.,
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
                          "S'inscrire",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "Créez un compte pour vous enregistrer",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.only(bottom: 15, top: 20),
                      child: SizedBox(
                        height: 50.0,
                        child: TransAcademiaNameInput(
                          field: "matricule",
                          controller: nomController,
                          hintText: "Numéro matricule",
                          color: Colors.white,
                          label: "Numéro matricule",
                        ),
                      )),
                      const SizedBox(
                        height: 10.0,
                      ),

                  const TransAcademiaDropdown(
                    items: "universiteData",
                    value: "universite",
                    label: "Choisir Université",
                    hintText: "choisir Université",
                  ),

       

                  SizedBox(
                    height: getProportionateScreenHeight(200),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                checked = !checked;
                              });
                            },
                            child: Icon(
                              checked == false
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box,
                              color: primaryColor,
                            )),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          "J'ai lu et je suis d'accord avec le",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Terms et Conditions",
                          style: TextStyle(color: primaryColor, fontSize: 12),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      StepIndicatorWidget(
                        color: Colors.blueAccent,
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Signup()),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            height: 50.0,
                            width: 150.0,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupStep2(isStudentPage: false,)),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            height: 50.0,
                            width: 150.0,
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

                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.20,
                  // ),
                  // Text("A propos",style:GoogleFonts.montserrat(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
