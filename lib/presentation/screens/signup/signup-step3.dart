// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/home/home_screen.dart';
import 'package:icecream_service/presentation/screens/signup/camera.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step1.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step2.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
// ignore: unused_import
import 'package:icecream_service/locale/all_translations.dart';
import 'package:icecream_service/presentation/widgets/inputs/dateField.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:icecream_service/presentation/widgets/inputs/dropdownUniversite.dart';
import 'package:icecream_service/presentation/widgets/inputs/nameField.dart';
import 'package:icecream_service/presentation/widgets/stepIndicator.dart';
import 'package:icecream_service/routestack.dart';
// import 'package:icecream_service/models/base.model.dart';
// import 'package:icecream_service/screens/home/home.dart';
// import 'package:icecream_service/screens/signup/signup1.dart';
// import 'package:icecream_service/services/http/user.service.dart';
import 'package:icecream_service/sizeconfig.dart';
import 'package:icecream_service/theme.dart';
import 'package:icecream_service/presentation/widgets/inputs/passwordTextField.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/presentation/widgets/inputs/passwordTextField.dart';
import 'package:icecream_service/theme.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class SignupStep3 extends StatefulWidget {
  bool backNavigation;
  SignupStep3({Key? key, required this.backNavigation}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupStep3State createState() => _SignupStep3State();
}

class _SignupStep3State extends State<SignupStep3> {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[(a-zA-Z0-9)]+\.[a-zA-Z]+");
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;
  bool checked = true;
  bool isWoman = false;
  File? image;
  String profilePicLink = "";

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controllerTakePicture; //controller for camera
  XFile? imageTakePicture; //for captured image
  final _picker = ImagePicker();
  var provinces = [];
  var dataAbonnement = [], prixCDF, prixUSD;
  // var abonnements = [];
  final Uri _url = Uri.parse('https://trans-academia.cd/privacy.html');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
    loadCamera();
    getDataProvinces();
    getDataListAbonnement();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "currency", data: "");
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "password", data: "");
    BlocProvider.of<SignupCubit>(context).initForm();
  }

  Future<void> launchUrlSite() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
  }

  String stateInfoUrl = 'https://api.trans-academia.cd/';
  void getDataProvinces() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_liste_Province.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        provinces = data['donnees'];
      });

      provinces;
    });
  }

  void getDataListAbonnement() async {
    await http.post(Uri.parse("${stateInfoUrl}Trans_Liste_Abonement.php"),
        body: {'App_name': "app", 'token': "2022"}).then((response) {
      var data = json.decode(response.body);

//      print(data);

      dataAbonnement =
          data['donnees'].where((e) => e['Type'] == 'Prelevement').toList();
      prixUSD = dataAbonnement[0]['prix_USD'];

      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "prixCDF", data: dataAbonnement[0]['prix_CDF']);
      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "prixUSD", data: dataAbonnement[0]['prix_USD']);
      BlocProvider.of<SignupCubit>(context).updateField(context,
          field: "abonnement", data: dataAbonnement[0]['id']);
    });
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controllerTakePicture =
          CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controllerTakePicture!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          image = File(imageTakePicture!.path);
        });
      });
    } else {
      if (kDebugMode) {
        print("NO any camera found");
      }
    }
  }

  // Implementing the image picker
  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });

      Reference ref = FirebaseStorage.instance.ref();

      await ref.putFile(File(pickedImage.toString()));

      ref.getDownloadURL().then((value) async {
        setState(() {
          profilePicLink = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ToastContext().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          Text(
                            "Créer un mot de passe sécurisé",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          Text(
                            "Plus le mot de passe est difficile à trouver,\ncela est mieux et plus sûre",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 130, 127, 127)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // const TransAcademiaDropdown(
                    //   items: "communeData",
                    //   value: "commune",
                    //   label: "Choisir la commune",
                    //   hintText: "choisir la commune",
                    // ),
                    // Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //     margin: const EdgeInsets.only(bottom: 15),
                    //     // color: backgroundInput,
                    //     child: TransAcademiaDropdownProvince(
                    //       data: provinces,
                    //       value: "province",
                    //       label: "Choisir la province",
                    //       hintText: "choisir la province",
                    //     )),
                    // BlocBuilder<SignupCubit, SignupState>(
                    //     builder: (context, state) {
                    //   return Container(
                    //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //       margin: const EdgeInsets.only(bottom: 15),
                    //       child: SizedBox(
                    //         height: 50.0,
                    //         child: TransAcademiaPhoneNumber(
                    //           number: 20,
                    //           controller: phoneController,
                    //           hintText: "Numéro de téléphone",
                    //           color: Colors.white,
                    //           field: "phone",
                    //           fieldValue: state.field!["phone"],
                    //         ),
                    //       ));
                    // }),
                    // BlocBuilder<SignupCubit, SignupState>(
                    //   builder: (context, state) {
                    //     return Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //         margin: const EdgeInsets.only(bottom: 15),
                    //         child: SizedBox(
                    //           height: 50.0,
                    //           child: TransAcademiaNameInput(
                    //             hintText: "Email",
                    //             color: Colors.white,
                    //             label: "Email",
                    //             field: "email",
                    //             fieldValue: state.field!["email"],
                    //           ),
                    //         ));
                    //   },
                    // ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        margin: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          height: 50.0,
                          child: BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return TransAcademiaPasswordField(
                                controller: passwordController,
                                label: "Mot de passe",
                                hintText: "mot de passe",
                                color: Colors.white12,
                                field: "password",
                                fieldValue: state.field!["password"],
                              );
                            },
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        margin: const EdgeInsets.only(bottom: 15),
                        // color: backgroundInput,
                        child: SizedBox(
                          height: 50.0,
                          child: BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return TransAcademiaPasswordField(
                                controller: passwordController,
                                label: "Confirmer mot de passe",
                                hintText: "Confirmer mot de passe",
                                color: Colors.white12,
                                field: "confirmPassword",
                                fieldValue: state.field!["confirmPassword"],
                              );
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    // BlocBuilder<SignupCubit, SignupState>(
                    //   builder: (context, state) {
                    //     return InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => CameraPage(
                    //                       type: "inscription",
                    //                       id: state.field!['id'],
                    //                     )));

                    //       },
                    //       child: BlocBuilder<SignupCubit, SignupState>(
                    //         builder: (context, state) {
                    //           return Container(
                    //               padding: const EdgeInsets.all(15.0),
                    //               decoration: BoxDecoration(
                    //                   border: state.field!['filePath'] != ''
                    //                       ? null
                    //                       : Border.all(color: Colors.blueAccent),
                    //                   borderRadius: BorderRadius.circular(50.0)),
                    //               child: state.field!['filePath'] != ''
                    //                   ? Stack(
                    //                       children: [
                    //                         Container(
                    //                           width: 90.0,
                    //                           height: 90.0,
                    //                           decoration: BoxDecoration(
                    //                               image: DecorationImage(
                    //                                   image: FileImage(File(state
                    //                                       .field!['filePath'])),
                    //                                   fit: BoxFit.cover),
                    //                               borderRadius:
                    //                                   const BorderRadius.all(
                    //                                       Radius.circular(50.0)),
                    //                               border: Border.all(
                    //                                   width: 1,
                    //                                   color: Colors.blueAccent)),
                    //                         ),
                    //                         Positioned(
                    //                             bottom: 0,
                    //                             right: 0,
                    //                             child: Container(
                    //                               height: 40,
                    //                               width: 40,
                    //                               decoration: BoxDecoration(
                    //                                   color: primaryColor,
                    //                                   borderRadius:
                    //                                       BorderRadius.circular(
                    //                                           50.0)),
                    //                               child: const Icon(
                    //                                 Icons.edit,
                    //                                 color: Colors.white,
                    //                               ),
                    //                             )),
                    //                       ],
                    //                     )
                    //                   : SvgPicture.asset(
                    //                       "assets/images/Avatar.svg",
                    //                       width: 60,
                    //                     ));
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),

                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.check,
                                  color: Color.fromARGB(255, 130, 127, 127))),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "Doit contenir à la fois des chiffres et \ndes lettres",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 130, 127, 127)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.check,
                                  color: Color.fromARGB(255, 130, 127, 127))),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "Doit contenir au moins 8 caractères",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 130, 127, 127)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.check,
                                  color: Color.fromARGB(255, 130, 127, 127))),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "Doit contenir un caractère spécial \n(par exemple !@#\$?&)",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 130, 127, 127)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.check,
                                  color: Color.fromARGB(255, 130, 127, 127))),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "Les mots de passe doivent correspondre",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 130, 127, 127)),
                          ),
                        ],
                      ),
                    ),
                    passwordError == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  passwordError.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        StepIndicatorWidget(
                          color: Colors.blueAccent,
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
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    submitError == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, top: 20.0),
                            child: Text(
                              submitError.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                BlocProvider.of<SignupCubit>(context)
                                        .updateField(context,
                                            field: "phonePayment", data: "");
                                    // if (state.field!["province"] == "") {
                                    //   ValidationDialog.show(context,
                                    //       "Veuillez sélectionner la province",
                                    //       () {
                                    //     if (kDebugMode) {
                                    //       print("modal");
                                    //     }
                                    //   });
                                    //   return;
                                    // }

                                    if (state.field!["phone"] == "") {
                                      ValidationDialog.show(context,
                                          "veuillez saisir le numéro de téléphone",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    if (state.field!["phone"].substring(0, 1) ==
                                            "0" ||
                                        state.field!["phone"].substring(0, 1) ==
                                            "+") {
                                      ValidationDialog.show(context,
                                          "Veuillez saisir le numéro avec le format valide, par exemple: (826016607).",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    if (state.field!["phone"].length < 9) {
                                      ValidationDialog.show(context,
                                          "Le numéro de téléphone ne doit pas avoir moins de 9 chiffres",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    // if (state.field!["email"] == "") {
                                    //   ValidationDialog.show(
                                    //       context, "veuillez saisir l'email", () {
                                    //     if (kDebugMode) {
                                    //       print("modal");
                                    //     }
                                    //   });
                                    //   return;
                                    // }

                                    // if (!emailValid
                                    //     .hasMatch(state.field!["email"])) {
                                    //   ValidationDialog.show(context,
                                    //       "le format d'email est incorrecte", () {
                                    //     if (kDebugMode) {
                                    //       print("modal");
                                    //     }
                                    //   });
                                    //   return;
                                    // }

                                    // if (!state.field!["email"].contains("@") ||
                                    //     !state.field!["email"].contains(".")) {
                                    //   ValidationDialog.show(context,
                                    //       "le format d'email est incorrecte", () {
                                    //     if (kDebugMode) {
                                    //       print("modal");
                                    //     }
                                    //   });
                                    //   return;
                                    // }

                                    if (state.field!["password"] == "") {
                                      ValidationDialog.show(context,
                                          "veuillez saisir le mot de passe", () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    if (!regex
                                        .hasMatch(state.field!["password"])) {
                                      ValidationDialog.show(context,
                                          "le format mot de passe est incorrecte \n. plus de 8 caractères\n. Minimum 1 majuscule\n. Minimum 1 minuscule\n. Minimum 1 Nombre numérique\n. Minimum 1 caractère spécial\n. Caractère autorisé  ! @ # \$ & * ~ ",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    if (state.field!["password"] !=
                                        state.field!["confirmPassword"]) {
                                      ValidationDialog.show(context,
                                          "les mots de passe saisis ne sont pas identiques",
                                          () {
                                        if (kDebugMode) {
                                          print("modal");
                                        }
                                      });
                                      return;
                                    }

                                    // if (state.field!["filePath"] == "") {
                                    //   ValidationDialog.show(
                                    //       context, "veuillez capturer la photo",
                                    //       () {
                                    //     if (kDebugMode) {
                                    //       print("modal");
                                    //     }
                                    //   });
                                    //   return;
                                    // }

                                    // TransAcademiaLoadingDialog.show(context);
                                    // BlocProvider.of<SignupCubit>(context)
                                    //     .updateField(context,
                                    //         data: state.field!["phone"],
                                    //         field: "phonePayment");

                                    //scannage

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupStep1()),
                                    );

                                    // fin scannage
                         
                              },
                              child:
                                  const ButtonTransAcademia(title: "Confirmer"),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
