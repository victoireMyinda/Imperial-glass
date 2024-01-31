// ignore_for_file: use_build_context_synchronously, unnecessary_const

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdowncream.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandeDuJourScreen extends StatefulWidget {
  const CommandeDuJourScreen({super.key});
  // final List dataPrice;
  // final String idCourse;

  @override
  State<CommandeDuJourScreen> createState() => _CommandeDuJourScreenState();
}

class _CommandeDuJourScreenState extends State<CommandeDuJourScreen> {
  List<Widget> formSectionColis = [];

  TextEditingController natureColisController = TextEditingController();
  TextEditingController nomColisController = TextEditingController();
  TextEditingController descriptionColisController = TextEditingController();
  TextEditingController poidsColisController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
    // TextEditingController volumeController = TextEditingController();
    //   TextEditingController productController = TextEditingController();

  @override
  void initState() {
    super.initState();
      BlocProvider.of<SignupCubit>(context).loadProductCream();
      BlocProvider.of<SignupCubit>(context).loadVolumeCream();
    addNewColis();
    // getPrice();
    // getProfilAgent();
    // BlocProvider.of<SignupCubit>(context)
    //     .updateField(context, field: "sumPoids", data: 0.0);
  }

  // calculateSumOfWeights(List dataList, double prixVoyage, double prixFret,
  //     double sumPoids, double fretOffert, double prixCourrier) {
  //   double sumPoids = dataList
  //       .map((item) => (item['poids'] ?? 0.0) as double)
  //       .fold(0, (prev, poids) => prev + poids);

  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "sumPoids", data: sumPoids);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => AbonnementScreen(
  //               prixVoyage: prixVoyage,
  //               prixFret: prixFret,
  //               sumPoids: sumPoids,
  //               fretOffert: fretOffert,
  //               prixCourrier: prixCourrier,
  //               typeReservation: "voyage",
  //             )),
  //   );
  // }

  // void getPrice() {
  //   final Map<String, dynamic>? foundItem =
  //       findItemById(widget.dataPrice, widget.idCourse);

  //   // Print the found item
  //   if (foundItem != null) {
  //     double prixVoyage = double.parse(foundItem['prix_voyage']);
  //     double prixFret = double.parse(foundItem['prix_fret']);
  //     double prixCourrier = double.parse(foundItem['prix_courrier']);
  //     double fretOffert = double.parse(foundItem['fret_offert']);

  //     print(foundItem['libele_ligne']);
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "prixVoyage", data: prixVoyage);
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "prixFret", data: prixFret);
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "prixCourrier", data: prixCourrier);
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "fretOffert", data: fretOffert);
  //   } else {
  //     print('Item with ID ${widget.idCourse} not found');
  //   }
  // }

  Map<String, dynamic>? findItemById(List dataList, String targetId) {
    return dataList.firstWhere((item) => item['id'] == targetId,
        orElse: () => null);
  }

  // getProfilAgent() async {
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "poidsList", data: []);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "currency", data: "");
  //   BlocProvider.of<SignupCubit>(context).updateField(context,
  //       field: "idAgent", data: prefs.getString('idAgent'));
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "idUser", data: prefs.getString('id'));
  // }

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
                                field: "descriptionColis",
                                controller: descriptionColisController,
                                hintText: "Description commande",
                                label: "Description commande",
                                fieldValue: state.field!["descriptionColis"],
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
                                items: "provinceDataKelasi",
                                value: "province",
                                controller: provinceController,
                                hintText: "Choisir le site",
                                color: Colors.white,
                                label: "Choisir le site",
                              ),
                            ));
                      },
                    ),
                    
                    for (int i = 0; i < formSectionColis.length; i++)
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
                            formSectionColis[i],
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
                          // if (state.field!["natureColis"] == "") {
                          //   ValidationDialog.show(
                          //       context, "Veuillez choisir la nature du colis",
                          //       () {
                          //     if (kDebugMode) {
                          //       print("modal");
                          //     }
                          //   });
                          //   return;
                          // }

                          // if (state.field!["poids"] == "0") {
                          //   ValidationDialog.show(
                          //       context, "le poids doit être superiuer à 0",
                          //       () {
                          //     if (kDebugMode) {
                          //       print("modal");
                          //     }
                          //   });
                          //   return;
                          // }

                          // double parsedValue;
                          // try {
                          //   parsedValue = double.parse(state.field!["poids"]);
                          // } catch (e) {
                          //   parsedValue = 0.0;
                          // }
                          // Map colisObject = {
                          //   "poids": parsedValue,
                          //   "Id_recever": state.field!["idClient"],
                          //   "Id_type_colis": state.field!["natureColis"],
                          //   "Id_user_created_at": state.field!["idUser"]
                          // };

                          // List? poidsList = state.field!["poidsList"];

                          // poidsList!.add(colisObject);

                          // print("object: " + poidsList.toString());

                          // BlocProvider.of<SignupCubit>(context).updateField(
                          //     context,
                          //     field: "poidsList",
                          //     data: poidsList);

                          // BlocProvider.of<SignupCubit>(context).updateField(
                          //     context,
                          //     field: "natureColis",
                          //     data: "");
                          // BlocProvider.of<SignupCubit>(context)
                          //     .updateField(context, field: "poids", data: "10");

                          // calculateSumOfWeights(poidsList);

                          addNewColis();
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
                formSectionColis.isEmpty
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
                                  // onTap: () {
                                  //   if (state.field!["natureColis"] == "" ||
                                  //       state.field!["natureColis"] == null) {
                                  //     ValidationDialog.show(context,
                                  //         "Veuillez choisir la nature du colis",
                                  //         () {
                                  //       if (kDebugMode) {
                                  //         print("modal");
                                  //       }
                                  //     });
                                  //     return;
                                  //   }
                                  //   double parsedValue;
                                  //   try {
                                  //     parsedValue =
                                  //         double.parse(state.field!["poids"]);
                                  //   } catch (e) {
                                  //     parsedValue = 0.0;
                                  //   }
                                  //   Map colisObject = {
                                  //     "poids": parsedValue,
                                  //     "Id_recever": state.field!["idClient"],
                                  //     "Id_type_colis":
                                  //         state.field!["natureColis"],
                                  //     "Id_user_created_at":
                                  //         state.field!["idUser"]
                                  //   };

                                  //   List? poidsList = state.field!["poidsList"];

                                  //   poidsList!.add(colisObject);

                                  //   BlocProvider.of<SignupCubit>(context)
                                  //       .updateField(context,
                                  //           field: "poidsList",
                                  //           data: poidsList);

                                  //   calculateSumOfWeights(
                                  //       poidsList,
                                  //       state.field!["prixVoyage"],
                                  //       state.field!["prixFret"],
                                  //       state.field!["sumPoids"],
                                  //       state.field!["fretOffert"],
                                  //       state.field!["prixCourrier"]);
                                  // },
                                  child: const ButtonTransAcademia(
                                      width: 320, title: "Commander"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNewColis() {
    setState(() {
      Key key = UniqueKey();
      formSectionColis.add(
        Container(
          key: key,
          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
          // margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        height: 50.0,
                        child: KelasiDropdown(
                          items: "productData",
                          value: "product",
                          // controller: productController,
                          hintText: "Produit à commander",
                          color: Colors.white,
                          label: "Produit à commander",
                        ),
                      ));
                },
              ),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        height: 50.0,
                        child: KelasiDropdown(
                          items: "volumeData",
                          value: "volume",
                          // controller: volumeController,
                          hintText: "Volume",
                          color: Colors.white,
                          label: "Volume",
                        ),
                      ));
                },
              ),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.only(
                        bottom: 30,
                      ),
                      child: SizedBox(
                        height: 50.0,
                        child: TransAcademiaNameInput(
                          field: "descriptionColis",
                          controller: descriptionColisController,
                          hintText: "Quantité ",
                          label: "Quantité ",
                          fieldValue: state.field!["descriptionColis"],
                        ),
                      ));
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
      formSectionColis.removeWhere((section) => section.key == key);
    });
  }
}
