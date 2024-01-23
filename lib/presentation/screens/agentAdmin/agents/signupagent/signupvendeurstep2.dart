import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/listeagent.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/sizeconfig.dart';

class SignupVendeurStep2 extends StatefulWidget {
  const SignupVendeurStep2({super.key});

  @override
  State<SignupVendeurStep2> createState() => _SignupVendeurStep2State();
}

class _SignupVendeurStep2State extends State<SignupVendeurStep2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color(0xffF2F2F2),
          child: Column(
            children: [
              AppBarKelasi(
                title: "Enregistrement de l'agent",
                leftIcon: "assets/icons/rowback-icon.svg",
                backgroundColor: Colors.white,
                onTapFunction: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode.name != "dark"
                            ? Colors.white
                            : Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
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
                              children: [
                                const SizedBox(height: 30),
                                const Text(
                                  "Vueillez renseigner l'adresse de l'agent",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropdown(
                            items: "provinceData",
                            value: "province",
                            label: "Choisir la province",
                            hintText: "Choisir la province",
                          ),
                          const SizedBox(height: 10),
                          const TransAcademiaDropdown(
                            items: "villeData",
                            value: "ville",
                            label: "Choisir la ville",
                            hintText: "Choisir la ville",
                          ),
                          const SizedBox(height: 10),
                          const TransAcademiaDropdown(
                            items: "communeData",
                            value: "commune",
                            label: "Choisir la commune",
                            hintText: "Choisir la commune",
                          ),
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
                                    hintText: "Quartier",
                                    field: "quartier",
                                    label: "Quartier",
                                    fieldValue: state.field!["quartier"],
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
                                    hintText: "Avenue et numero",
                                    field: "avenue",
                                    label: "Avenue/Numero",
                                    fieldValue: state.field!["avenue"],
                                  ),
                                ));
                          }),
                          const SizedBox(height: 10),
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
                                color: MyColors.myBrown,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<SignupCubit, SignupState>(
                                    builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: ButtonTransAcademia(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        title: "Precedent"),
                                  );
                                }),
                                BlocBuilder<SignupCubit, SignupState>(
                                    builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListeAgentsScreen()),
                                      );
                                    },
                                    child: ButtonTransAcademia(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        title: "Suivant"),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
