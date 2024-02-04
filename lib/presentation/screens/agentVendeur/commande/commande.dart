// ignore_for_file: use_build_context_synchronously, unnecessary_const

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdowncream.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandeDuJourScreen extends StatefulWidget {
  const CommandeDuJourScreen({super.key});

  @override
  State<CommandeDuJourScreen> createState() => _CommandeDuJourScreenState();
}

class _CommandeDuJourScreenState extends State<CommandeDuJourScreen> {
  Map? commandeObject;
  List? ligneCommande = [];
  List<Widget> formSectionProduct = [];

  TextEditingController siteController = TextEditingController();
  TextEditingController descriptionProduitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadProductCream();
    BlocProvider.of<SignupCubit>(context).loadVolumeCream();
    BlocProvider.of<SignupCubit>(context).loadSiteCream();

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "ligneCommande", data: []);

    addNewProduct();
    getProfilAgent();
  }

  getProfilAgent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "idAgent", data: prefs.getString('id'));
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "idUser", data: prefs.getString('idUser'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Commande du jour",
          leftIcon: "assets/icons/rowback-icon.svg",
          sizeleftIcon: 12,
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 245, 244, 244),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Column(
                  children: [
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaNameInput(
                                field: "descriptionProduit",
                                controller: descriptionProduitController,
                                hintText: "Description commande",
                                label: "Description commande",
                                fieldValue: state.field!["descriptionProduit"],
                              ),
                            ));
                      },
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 50.0,
                              child: KelasiDropdown(
                                items: "siteData",
                                value: "site",
                                controller: siteController,
                                hintText: "Choisir le site",
                                color: Colors.white,
                                label: "Choisir le site",
                              ),
                            ));
                      },
                    ),
                    for (int i = 0; i < formSectionProduct.length; i++)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 141, 140, 140),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            formSectionProduct[i],
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  width: 330,
                  child: BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (state.field!["product"] == "") {
                            ValidationDialog.show(
                                context, "Veuillez choisir le produit", () {
                              if (kDebugMode) {
                                print("modal");
                              }
                            });
                            return;
                          }

                          if (state.field!["volume"] == "") {
                            ValidationDialog.show(
                                context, "Veuillez choisir le volume", () {
                              if (kDebugMode) {
                                print("modal");
                              }
                            });
                            return;
                          }

                          if (state.field!["quantiteProduit"] == "") {
                            ValidationDialog.show(
                                context, "Quantité ne doit pas etre vide", () {
                              if (kDebugMode) {
                                print("modal");
                              }
                            });
                            return;
                          }

                          commandeObject = {
                            "quantity":
                                int.parse(state.field!["quantiteProduit"]),
                            "ID_quantity_unit":
                                int.parse(state.field!["volume"]),
                            "ID_product": int.parse(state.field!["product"]),
                          };

                          // ligneCommande = state.field!["ligneCommande"];

                          ligneCommande!.add(commandeObject);

                          // print(ligneCommande);

                          //  print("object: " + ligneCommande.toString());

                          // BlocProvider.of<SignupCubit>(context).updateField(
                          //     context,
                          //     field: "ligneCommande",
                          //     data: ligneCommande);

                          addNewProduct();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            const Text(
                              'Ajouter un nouveau produit',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: MyColors.myBrown),
                            ),
                            Icon(
                              Icons.production_quantity_limits_outlined,
                              color: MyColors.myBrown,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                formSectionProduct.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              // color: Color.fromARGB(255, 93, 92, 92),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: const [
                              Image(
                                image: AssetImage("assets/images/icecream.jpg"),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Cliquez sur le boutton ci-haut pour ajouter un produit.",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (state.field!["descriptionProduit"] ==
                                        "") {
                                      ValidationDialog.show(context,
                                          "Veuillez decrire le titre de votre commande",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    // commandeObject = {
                                    //   "quantity": int.parse(
                                    //       state.field!["quantiteProduit"]),
                                    //   "ID_quantity_unit":
                                    //       state.field!["volume"],
                                    //   "ID_product": state.field!["product"],
                                    // };

                                    // ligneCommande!.add(commandeObject);

                                    Map data = {
                                      "description":
                                          state.field!["descriptionProduit"],
                                      "ID_ordering_agent":
                                          int.parse(state.field!["idAgent"]),
                                      "Id_user_created_at":
                                          int.parse(state.field!["idUser"]),
                                      "ID_sale_site":
                                          int.parse(state.field!["site"]),
                                      "line": ligneCommande,
                                    };

                                    Map? response = await SignUpRepository
                                        .createCommandeCream(data);
                                    // print(response);

                                    if (response["status"] == 201) {
                                      TransAcademiaLoadingDialog.stop(context);
                                      String? messageSucces =
                                          response["message"];
                                      TransAcademiaDialogSuccess.show(
                                          context, messageSucces, "Auth");

                                      try {
                                        Future.delayed(
                                            const Duration(milliseconds: 4000),
                                            () async {
                                          TransAcademiaDialogSuccess.stop(
                                              context);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/home',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      } catch (e) {
                                        print(
                                            "Exception during navigation: $e");
                                      }
                                    } else if (response["status"] == 400) {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogError.show(
                                        context,
                                        response["message"],
                                        "login",
                                      );
                                      Future.delayed(
                                          const Duration(milliseconds: 4000),
                                          () {
                                        TransAcademiaDialogError.stop(context);
                                      });
                                    } else {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogError.show(context,
                                          response["message"], "login");
                                    }
                                  },
                                  child: const ButtonTransAcademia(
                                      width: 320, title: "Commander"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNewProduct() {
    TextEditingController volumeController = TextEditingController();
    TextEditingController productController = TextEditingController();
    TextEditingController quantiteProduitController = TextEditingController();

    setState(() {
      Key key = UniqueKey();

      formSectionProduct.add(
        Container(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 30),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 50.0,
                      child: KelasiDropdown(
                        items: "productData",
                        value: "product",
                        controller: productController,
                        hintText: "Produit à commander",
                        color: Colors.white,
                        label: "Produit à commander",
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 50.0,
                      child: KelasiDropdown(
                        items: "volumeData",
                        value: "volume",
                        controller: volumeController,
                        hintText: "Volume",
                        color: Colors.white,
                        label: "Volume",
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      height: 50.0,
                      child: TransAcademiaNameInput(
                        field: "quantiteProduit",
                        controller: quantiteProduitController,
                        hintText: "Quantité ",
                        label: "Quantité ",
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    removeSectionColis(key);
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.cancel,
                      color: Colors.grey.shade400,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void removeSectionColis(Key key) {
    setState(() {
      formSectionProduct.removeWhere((section) => section.key == key);
    });
  }
}
