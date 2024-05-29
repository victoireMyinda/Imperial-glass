import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/produit.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
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
                          const SizedBox(height: 20),
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
                                    isError: state.field!["descProduitError"],
                                    hintText: "Description produit",
                                    field: "descProduit",
                                    label: "Description produit",
                                    fieldValue: state.field!["descProduit"],
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
                                    isError: state.field!["prixProduitError"],
                                    hintText: "Prix unitaire",
                                    field: "prixProduit",
                                    label: "Prix unitaire",
                                    fieldValue: state.field!["prixProduit"],
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
                                    isError: state.field!["qteProduitError"],
                                    hintText: "Quantité",
                                    field: "qteProduit",
                                    label: "Quantité",
                                    fieldValue: state.field!["qteProduit"],
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
                                    onTap: () async {
                                      if (state.field!["descProduit"] == "") {
                                        BlocProvider.of<SignupCubit>(context)
                                            .updateField(context,
                                                field: "descProduitError",
                                                data: "error");
                                        ValidationDialog.show(context,
                                            "Veuillez renseigner la description",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["prixProduit"] == "") {
                                        BlocProvider.of<SignupCubit>(context)
                                            .updateField(context,
                                                field: "prixProduitError",
                                                data: "error");
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer le prix.", () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                      if (state.field!["qteProduit"] == "") {
                                        BlocProvider.of<SignupCubit>(context)
                                            .updateField(context,
                                                field: "qteProduitError",
                                                data: "error");
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer la quantité.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                      TransAcademiaLoadingDialog.show(context);
                                      Map data = {
                                        "description":
                                            state.field!["descProduit"],
                                        "unit_price": int.tryParse(
                                            state.field!["prixProduit"]),
                                        "unit_quatity": int.tryParse(
                                            state.field!["qteProduit"]),
                                        "ID_user_created_at": int.tryParse(
                                            state.field!["idUser"]),
                                        "volume": 1,
                                        "ID_currency": 1,
                                        "is_available": 1,
                                      };

                                      // print(data);

                                      Map? response = await SignUpRepository
                                          .createProductCream(data);
                                      //  print(response);

                                      int status = response["status"];
                                      String? message = response["message"];

                                      if (status == 201) {
                                        TransAcademiaLoadingDialog.stop(
                                            context);
                                        String? messageSucces =
                                            "Produit crée avec succès";
                                        TransAcademiaDialogSuccess.show(
                                            context, messageSucces, "Signup");

                                        Future.delayed(
                                            const Duration(milliseconds: 4000),
                                            () async {
                                          TransAcademiaDialogSuccess.stop(
                                              context);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/routestack',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      } else {
                                        TransAcademiaLoadingDialog.stop(
                                            context);
                                        TransAcademiaDialogError.show(
                                            context, message, "login");
                                      }
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
