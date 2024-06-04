import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdowncream.dart';
import 'package:icecream_service/sizeconfig.dart';

class AffectationAgent extends StatefulWidget {
  AffectationAgent({super.key, required this.data});
  Map? data;

  @override
  State<AffectationAgent> createState() => _AffectationAgentState();
}

class _AffectationAgentState extends State<AffectationAgent> {
  TextEditingController siteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SignupCubit>(context).loadSiteCream();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Affectation de l'agent",
          backgroundColor: Colors.white,
          leftIcon: "assets/icons/rowback-icon.svg",
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: Center(
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KelasiDropdown(
                  items: "siteData",
                  value: "site",
                  controller: siteController,
                  hintText: "Choisir le site",
                  color: Colors.white,
                  label: "Choisir le site",
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            TransAcademiaLoadingDialog.show(context);

                            Map data = {
                              "ID_sale_site": int.tryParse(state.field!["site"])
                            };

                            Map? response =
                                await SignUpRepository.affectationAgent(data,
                                    int.tryParse(widget.data!["agent_ID"]));
                            print(response);

                            int status = response["status"];
                            String? message = response["message"];

                            if (status == 200) {
                              TransAcademiaDialogSuccess.show(
                                  context, message, "Signup");

                              Future.delayed(const Duration(milliseconds: 4000),
                                  () async {
                                TransAcademiaDialogSuccess.stop(context);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/routestack',
                                    (Route<dynamic> route) => false);
                              });
                            } else {
                              TransAcademiaLoadingDialog.stop(context);
                              TransAcademiaDialogError.show(
                                  context, message, "affectation");
                            }
                          },
                          child: const ButtonTransAcademia(
                              width: 300, title: "Affecter"),
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
