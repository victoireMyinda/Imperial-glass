// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';

class TransAcademiaDropdownPayment extends StatefulWidget {
  const TransAcademiaDropdownPayment({
    super.key,
    this.controller,
    this.color,
    this.label,
    this.hintText,
    this.validator,
    this.number,
    this.items,
    this.paymentType,
    this.height
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final int? paymentType;
  final String? items;
  final double? height;

  @override
  _TransAcademiaDropdownPaymentState createState() =>
      _TransAcademiaDropdownPaymentState();
}

class _TransAcademiaDropdownPaymentState
    extends State<TransAcademiaDropdownPayment> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  String? labelForDropdown;

  @override
  void initState() {
    super.initState();
    labelForDropdown = "libele";
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "typePaymentFromApi", data: "");
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "typePayment", data: "2");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, stateSignup) {
        return Form(
          key: _dropdownFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AbonnementCubit, AbonnementState>(
                builder: (context, state) {
                  return Container(
                    height: widget.height ?? 70,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      itemHeight: 100.0,
                      borderRadius: BorderRadius.circular(20),
                      hint: Container(
                        width: MediaQuery.of(context).size.width/2 + 84,
                        child: const Text("Sélectionner le moyen de paiement"),
                      ),
                      dropdownColor:
                          AdaptiveTheme.of(context).mode.name == "dark"
                              ? Colors.black
                              : Colors.white,
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                          print(newValue);
                          var parts = newValue.split(" ");
                          if (kDebugMode) {
                            print(parts[1]);
                          }
                          if (parts[1] == "N") {
                            // provider == "EQUITYBCDC";
                            ValidationDialog.show(
                              context,
                              "Cher ${stateSignup.field!["prenom"]},\n\nCe moyen de paiement est indisponible pour l'instant, nous travaillons sur son rétablissement. Nous vous prions d'en choisir un autre.\n\nMerci",
                              () {
                                print("modal");
                              },
                            );
                            return;
                          }
                          if (parts[0].toString() == "EQUITYBCDC") {
                            BlocProvider.of<SignupCubit>(context).updateField(
                              context,
                              field: "inputVisible",
                              data: "false",
                            );
                            BlocProvider.of<SignupCubit>(context).updateField(
                              context,
                              field: "typePaymentFromApi",
                              data: parts[0].toString(),
                            );
                            BlocProvider.of<SignupCubit>(context).updateField(
                              context,
                              field: "disponibility",
                              data: parts[1].toString(),
                            );
                          } else {
                            BlocProvider.of<SignupCubit>(context).updateField(
                              context,
                              field: "inputVisible",
                              data: "true",
                            );
                            BlocProvider.of<SignupCubit>(context).updateField(
                              context,
                              field: "typePaymentFromApi",
                              data: parts[0].toString(),
                            );
                            BlocProvider.of<SignupCubit>(context).updateField(
                              context,
                              field: "disponibility",
                              data: parts[1].toString(),
                            );
                          }
                        });
                      },
                      items: state.field![widget.items]
                          .where((e) => e['STATUS'] == 'ACTIVED')
                          .map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem(
                          value: item['libele'].toString() +
                              " " +
                              item['is_disponible'].toString(),
                          child: Container(
                            child: Row(
                              children: [
                                logoContainer(
                                  "assets/images/${item['libele']}-trans.webp",
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(item['libele'])
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

OutlineInputBorder myinputborder() {
  // Retourne un OutlineInputBorder sans bordure inférieure
  return const OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(0), // Modifier le rayon pour la bordure inférieure
      bottomRight: Radius.circular(0), // Modifier le rayon pour la bordure inférieure
    ),
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 1,
    ),
  );
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
      color: Colors.white,
      width: 1,
    ),
  );
}

Container logoContainer(logo) {
  return Container(
    height: 30,
    width: 30,
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(color: Colors.blueAccent, width: 1),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(logo.toString()),
      ),
    ),
  );
}
