import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/produit.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/sizeconfig.dart';

class SignupProduit extends StatefulWidget {
  const SignupProduit({super.key});

  @override
  State<SignupProduit> createState() => _SignupProduitState();
}

class _SignupProduitState extends State<SignupProduit> {
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
          title: "Enregistrement produit",
          backgroundColor: Colors.white,
          leftIcon: "assets/icons/rowback-icon.svg",
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: Container(
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

                          Center(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/icon.png'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: MyColors.myBrown, width: 1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
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
                                  "Veuillez renseigner les informations du produit",
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
                                margin: const EdgeInsets.only(bottom: 15),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    isError: state.field!["nomError"],
                                    hintText: "Nom",
                                    field: "nom",
                                    label: "Nom",
                                    fieldValue: state.field!["nom"],
                                  ),
                                ));
                          }),
                          const SizedBox(height: 10),
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
                                    field: "Nature",
                                    label: "Nature",
                                    fieldValue: state.field!["prenom"],
                                  ),
                                ));
                          }),
                          const SizedBox(height: 10),
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
                                    field: "Nature",
                                    label: "Nature",
                                    fieldValue: state.field!["prenom"],
                                  ),
                                ));
                          }),
                          const SizedBox(height: 10),
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
                                    hintText: "Quantité",
                                    field: "quantite",
                                    label: "Quantité",
                                    fieldValue: state.field!["Quantité"],
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListProduitsScreen()),
                                      );
                                    },
                                    child: const ButtonTransAcademia(
                                        width: 300, title: "Enregistrer"),
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
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
            ],
          ),
        ),
      ),
    );
  }
}
