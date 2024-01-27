import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/signupagent/signupvendeurstep2.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/signupagent/signupvendeurstep3.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/inputs/dateField.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/sizeconfig.dart';

class SignupVendeurStep2 extends StatefulWidget {
  const SignupVendeurStep2({super.key});

  @override
  State<SignupVendeurStep2> createState() => _SignupVendeurStep2State();
}

class _SignupVendeurStep2State extends State<SignupVendeurStep2> {
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController dateEmbauche = TextEditingController();

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
          title: "Enregistrement de l'agent",
          backgroundColor: Colors.white,
          leftIcon: "assets/icons/rowback-icon.svg",
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
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
                              height: 30,
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
                                    "Veuillez renseigner l'identité de l'agent",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      isError: state.field!["postnomnomError"],
                                      hintText: "Postnom",
                                      field: "postnom",
                                      label: "Postnom",
                                      fieldValue: state.field!["postnom"],
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
                                      hintText: "Lieu de naissance",
                                      field: "lieuNaissance",
                                      label: "Lieu de naissance",
                                      fieldValue: state.field!["lieuNaissance"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    margin: const EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TransAcademiaDatePicker(
                                          controller: dateNaissanceController,
                                          hintText: "Date de naissance",
                                          color: Colors.white,
                                          label: "Date de naissance",
                                          field: "dateNaissance",
                                          fieldValue:
                                              state.field!["dateNaissance"]),
                                    ));
                              },
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    margin: const EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TransAcademiaDatePicker(
                                          controller: dateEmbauche,
                                          hintText: "Date d'embauche",
                                          color: Colors.white,
                                          label: "Date d'embauche",
                                          field: "dateNaissance",
                                          fieldValue:
                                              state.field!["dateNaissance"]),
                                    ));
                              },
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TransAcademiaNameInput(
                                        isError: state.field!["emailError"],
                                        hintText: "Votre adresse Email",
                                        color: Colors.white,
                                        label: "Votre adresse Email",
                                        field: "email",
                                        fieldValue: state.field!["email"],
                                      ),
                                    ));
                              },
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: ButtonTransAcademia(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          title: "Precedent"),
                                    );
                                  }),
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () async {
                                        TransAcademiaLoadingDialog.show(
                                            context);

                                        Map data = {
                                          "agent_id": 12,
                                          "first_name": state.field!["nom"],
                                          "second_name": state.field!["prenom"],
                                          "third_name": state.field!["postnom"],
                                          "phone": state.field!["phone"],
                                          "statut": "A",
                                          "OTP": 3899,
                                          "pwd": state.field!["pwd"],
                                          "pwd_confirm": state.field!["pwd"],
                                          "sex": state.field!["sexe"],
                                          "hired_at":
                                              state.field!["dateNaissance"],
                                          "function": "Agent",
                                          "Grade": "Directeur Info",
                                          "ID_service": 1,
                                          "ID_direction": 1,
                                          "ID_province": 1,
                                          "ID_commune": 3,
                                          "ID_ville": 1,
                                          "birth_place":
                                              state.field!["lieuNaissance"],
                                          "born_at":
                                              state.field!["dateNaissance"],
                                          "email": state.field!["email"],
                                          "photo_url": "url",
                                          "availability": 1
                                        };

                                        Map? response = await SignUpRepository
                                            .signupAgentCream(data);
                                        // print(response);

                                        int status = response["status"];
                                        String? message = response["message"];

                                        if (status == 201) {
                                          TransAcademiaLoadingDialog.stop(context);
                                          String? messageSucces =
                                              "La création de l'agent a été effectuée avec succès";
                                          TransAcademiaDialogSuccess.show(
                                              context, messageSucces, "Signup");

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 4000),
                                              () async {
                                            TransAcademiaDialogSuccess.stop(
                                                context);
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/home',
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
                                      child: ButtonTransAcademia(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          title: "Enregistrer"),
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
