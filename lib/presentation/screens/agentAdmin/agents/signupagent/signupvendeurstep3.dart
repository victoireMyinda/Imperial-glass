import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/listeagent.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/inputs/dateField.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdowncream.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/sizeconfig.dart';

class SignupVendeurStep3 extends StatefulWidget {
  const SignupVendeurStep3({super.key});

  @override
  State<SignupVendeurStep3> createState() => _SignupVendeurStep3State();
}

class _SignupVendeurStep3State extends State<SignupVendeurStep3> {
  TextEditingController provinceController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController quartierController = TextEditingController();
  TextEditingController avenueController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController dateEmbauche = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadProvincesKelasi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                                children: const [
                                  SizedBox(height: 30),
                                  Text(
                                    "Vueillez renseigner l'adresse de l'agent",
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
                                    // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    // margin: const EdgeInsets.only(bottom: 30, top: 20),
                                    child: SizedBox(
                                  height: 50.0,
                                  child: KelasiDropdown(
                                    items: "provinceDataKelasi",
                                    value: "province",
                                    controller: provinceController,
                                    hintText: "Province",
                                    color: Colors.white,
                                    label: "Province",
                                  ),
                                ));
                              },
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    margin: const EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: KelasiDropdown(
                                        items: "villeDataKelasi",
                                        value: "ville",
                                        controller: villeController,
                                        hintText: "Ville",
                                        color: Colors.white,
                                        label: "Ville",
                                      ),
                                    ));
                              },
                            ),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Container(
                                    // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    margin: const EdgeInsets.only(
                                        bottom: 30, top: 20),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: KelasiDropdown(
                                        items: "communeDataKelasi",
                                        value: "commune",
                                        controller: communeController,
                                        hintText: "Commune",
                                        color: Colors.white,
                                        label: "Commune",
                                      ),
                                    ));
                              },
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
                            Padding(
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
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        height: 50.0,
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.cyan,
                                              Colors.indigo,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Précedent",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () async {
                                        TransAcademiaLoadingDialog.show(
                                            context);

                                        Map data = {
                                          "first_name": state.field!["nom"],
                                          "second_name": state.field!["prenom"],
                                          "third_name": state.field!["postnom"],
                                          "phone": state.field!["phone"],
                                          "statut": "A",
                                          "OTP": 3899,
                                          "pwd": state.field!["pwd"],
                                          "pwd_confirm": state.field!["pwd"],
                                          "sex": state.field!["sexe"],
                                          "hired_at": state.field!["date"],
                                          "function": state.field!["fonction"],
                                          "Grade": state.field!["grade"],
                                          "Id_service": 1,
                                          "Id_direction": 1,
                                          "Id_province":
                                              state.field!["province"],
                                          "Id_ville": state.field!["ville"],
                                          "Id_commune": state.field!["commune"],
                                          "numero": state.field!["numero"],
                                          "birth_place": "Kikwit",
                                          "born_at": state.field!["date"],
                                          "email": state.field!["mail"],
                                          "photo": "url",
                                          "availability": 1
                                        };

                                        Map? response = await SignUpRepository
                                            .signupAgentCream(data);
                                        print(response);

                                        int status = response["status"];
                                        String? message = response["message"];

                                        if (status == 201) {
                                          //TransAcademiaLoadingDialog.stop(context);
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
                                        } else if (status == 403) {
                                          String? messageSucces =
                                              "Téléphone non connu ou inexistant. Rendez-vous à la direction pour vous enreigistrer";
                                          TransAcademiaDialogError.show(
                                              context, messageSucces, "Error");
                                          Future.delayed(const Duration(
                                              milliseconds: 4000));
                                          TransAcademiaLoadingDialog.stop(
                                              context);
                                        } else {
                                          TransAcademiaLoadingDialog.stop(
                                              context);
                                          TransAcademiaDialogError.show(
                                              context, message, "login");
                                        }
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        height: 50.0,
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.cyan,
                                              Colors.indigo,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Suivant",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
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
      ),
    );
  }
}
