import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/mescommandes/mescommandes.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/dateField.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/sizeconfig.dart';

class VenteDuJourScreen extends StatefulWidget {
  const VenteDuJourScreen({super.key});

  @override
  State<VenteDuJourScreen> createState() => _VenteDuJourScreenState();
}

class _VenteDuJourScreenState extends State<VenteDuJourScreen> {
  TextEditingController dateVenteController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "nom", data: "");

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "postnom", data: "");
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "prenom", data: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Vente du jour",
          backgroundColor: Colors.white,
          leftIcon: "assets/icons/rowback-icon.svg",
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            //padding: const EdgeInsets.all(3),
            color: const Color(0xffF2F2F2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.name != "dark"
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const SizedBox(height: 40),
                                  const Text(
                                    "Veuillez renseigner le rapport journalier",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    margin: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TransAcademiaDatePicker(
                                        controller: dateVenteController,
                                        hintText: "Date du jour",
                                        label: "Date du jour",
                                      ),
                                    ));
                              },
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "Heure du début",
                                      label: "Heure du début",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "Heure de la fin",
                                      label: "Heure de la fin",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "Quantité reçu",
                                      label: "Quantité reçu",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "Quantité vendue",
                                      label: "Quantité vendue",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "Produit restant",
                                      label: "Produit restant",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["prenomError"],
                                      hintText: "Prenom",
                                      field: "Total en chiffre",
                                      label: "Total en chiffre",
                                      fieldValue: state.field!["prenom"],
                                    ),
                                  ));
                            }),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        // if (state.field!["nom"] == "") {
                                        //   BlocProvider.of<SignupCubit>(context)
                                        //       .updateField(context,
                                        //           field: "nomError",
                                        //           data: "error");
                                        //   ValidationDialog.show(context,
                                        //       "Veuillez indiquer le nom de l'enfant.", () {
                                        //     if (kDebugMode) {
                                        //       print("modal");
                                        //     }
                                        //   });
                                        //   return;
                                        // }

                                        // if (state.field!["postnom"] == "") {
                                        //   BlocProvider.of<SignupCubit>(context)
                                        //       .updateField(context,
                                        //           field: "postnomError",
                                        //           data: "error");
                                        //   ValidationDialog.show(context,
                                        //       "Veuillez indiquer le postnom de l'enfant.",
                                        //       () {
                                        //     if (kDebugMode) {
                                        //       print("modal");
                                        //     }
                                        //   });
                                        //   return;
                                        // }

                                        // if (state.field!["prenom"] == "") {
                                        //   BlocProvider.of<SignupCubit>(context)
                                        //       .updateField(context,
                                        //           field: "prenomError",
                                        //           data: "error");
                                        //   ValidationDialog.show(context,
                                        //       "Veuillez indiquer le prénom de l'enfant.",
                                        //       () {
                                        //     if (kDebugMode) {
                                        //       print("modal");
                                        //     }
                                        //   });
                                        //   return;
                                        // }
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const SignupVendeurStep2()),
                                        // );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MesCommandesScreen()),
                                        );
                                      },
                                      child: const ButtonTransAcademia(
                                          width: 300, title: "Envoyer"),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
