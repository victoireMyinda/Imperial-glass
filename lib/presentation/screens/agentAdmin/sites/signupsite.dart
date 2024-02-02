import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/sites/sites.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/sizeconfig.dart';

class SignupSite extends StatefulWidget {
  const SignupSite({super.key});

  @override
  State<SignupSite> createState() => _SignupSiteState();
}

class _SignupSiteState extends State<SignupSite> {
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
                title: "Enregistrement du site",
                leftIcon: "assets/icons/rowback-icon.svg",
                backgroundColor: Colors.white,
                onTapFunction: () => Navigator.of(context).pop(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(5),
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
                                children: const [
                                  SizedBox(height: 30),
                                  Text(
                                    "Vueillez renseigner les informations du site",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                      hintText: "Nom du site",
                                      field: "nomsite",
                                      label: "Nom du site",
                                      fieldValue: state.field!["nomsite"],
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
                                      hintText: "Localisation",
                                      field: "localisationsite",
                                      label: "Localisation",
                                      fieldValue:
                                          state.field!["localisationsite"],
                                    ),
                                  ));
                            }),
                           
                            const SizedBox(height: 10),
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
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListSitesScreen()),
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
                              height: getProportionateScreenHeight(15),
                            ),
                          ],
                        ),
                      ),
                    ],
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
