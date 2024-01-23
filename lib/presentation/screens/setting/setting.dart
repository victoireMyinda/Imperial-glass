// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/login/login_screen.dart';
import 'package:icecream_service/presentation/screens/signup/camera.dart';
import 'package:icecream_service/presentation/widgets/caroussel.dart';
import 'package:icecream_service/presentation/widgets/imageview.dart';
import 'package:icecream_service/theme.dart';

import 'widgets/cardSetting.dart';
import 'widgets/cardNumberCourse.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  bool backNavigation;
  SettingScreen({Key? key, required this.backNavigation}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool status = false;
  String? photo;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chechThemeStatus();
    getProfilStudent();
    getCourse();
  }

  void getCourse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.getString('code'));
    

    await http.post(Uri.parse(
        "https://tag.trans-academia.cd/Api_viewProfil.php"
        ), body: {
      'IDetudiant': prefs.getString('code')
    }).then((response) {
      var data = json.decode(response.body);
      int status;
      print(data['donnees']);
      status = data['status'];
      if (status == 200) {
        BlocProvider.of<SignupCubit>(context).updateField(context,
            field: "course", data: data['donnees'][0]["Nombre Course"] ?? "");
        BlocProvider.of<SignupCubit>(context).updateField(context,
            field: "date", data: data['donnees'][0]["Date Expiration"] ?? "");
        BlocProvider.of<SignupCubit>(context).updateField(context,
            field: "photo", data: data['donnees'][0]["photo"] ?? "");
      } else {
        print('ok');
      }
    });
  }

  getProfilStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "phone", data: prefs.getString('phone'));
    // ignore: use_build_context_synchronously
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "id", data: prefs.getString('id'));

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "nom", data: prefs.getString('nom'));
    BlocProvider.of<SignupCubit>(context).updateField(context,
        field: "postnom", data: prefs.getString('postnom'));
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "prenom", data: prefs.getString('prenom'));
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "photo", data: prefs.getString('photo'));
  }

  chechThemeStatus() {
    if (AdaptiveTheme.of(context).mode.name == "dark") {
      setState(() {
        status = true;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // brightness: Brightness.light,
          leading: widget.backNavigation == false
              ? null
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AdaptiveTheme.of(context).mode.name != "dark"
                        ? Colors.black
                        : Colors.white,
                  )),
          title: Text(
            "Paramètres",
            style: TextStyle(
              fontSize: 14,
              color: AdaptiveTheme.of(context).mode.name != "dark"
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).bottomAppBarColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // color: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      return Container(
                          padding: EdgeInsets.all(
                              state.field!['photo'] == "" ? 15.0 : 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: state.field!['photo'] == "" ||
                                  state.field!['photo'] == "NULL"
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CameraPage(
                                                  type: "update",
                                                  id: state.field!['id'],
                                                )));
                                  },
                                  // child: SvgPicture.asset(
                                  //   "assets/images/Avatar.svg",
                                  //   width: 60,
                                  // ),

                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: SvgPicture.asset(
                                          "assets/images/Avatar.svg",
                                          width: 60,
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: 30.0,
                                            width: 30.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CameraPage(
                                                              type: "update",
                                                              id: state
                                                                  .field!['id'],
                                                            )));
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ))
                              : state.field!["photo"] == "STDTAC"
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: ImageViewerWidget(
                                        border: Border.all(
                                            width: 2, color: primaryColor),
                                        url:
                                            // ignore: prefer_interpolation_to_compose_strings
                                            "https://app.web.trans-academia.cd/app-assets/img/utilisateurs/" +
                                                state.field!["photo"],
                                        width: 80.0,
                                        height: 80.0,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: CircleAvatar(
                                            radius: 55,
                                            backgroundColor: kelasiColor,
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  AdaptiveTheme.of(context).mode.name != "dark"
                                                      ? Colors.white
                                                      : Colors.black87,
                                              child: ImageViewerWidget(
                                                border: Border.all(
                                                    width: 2,
                                                    color: primaryColor),
                                                url:
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    "https://app.web.trans-academia.cd/app-assets/img/utilisateurs/" +
                                                        state.field!["photo"],
                                                width: 90.0,
                                                height: 90.0,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: Container(
                                              height: 30.0,
                                              width: 30.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  color: kelasiColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CameraPage(
                                                                type: "update",
                                                                id: state
                                                                        .field![
                                                                    'id'],
                                                              )));
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ));
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                    return Text(
                      state.field!["prenom"] + "  " + state.field!["nom"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      showToast("Bientôt disponible",
                          duration: 3, gravity: Toast.bottom);
                    },
                    child: CardSetting(
                      title: "Changer de mot de passe",
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "changer de theme",
                        ),
                        FlutterSwitch(
                          width: 100.0,
                          height: 55.0,
                          toggleSize: 45.0,
                          value: status,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: kelasiColor,
                          inactiveToggleColor: kelasiColorIcon,
                          activeSwitchBorder: Border.all(
                            color: kelasiColor,
                            width: 6.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: kelasiColor,
                            width: 6.0,
                          ),
                          activeColor: kelasiColorIcon,
                          inactiveColor: Colors.white,
                          activeIcon: const Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFF8E3A1),
                          ),
                          inactiveIcon: const Icon(
                            Icons.wb_sunny,
                            color: Color(0xFFFFDF5D),
                          ),
                          onToggle: (val) {
                            setState(() {
                              status = val;

                              if (status == false) {
                                AdaptiveTheme.of(context).setLight();
                              } else {
                                AdaptiveTheme.of(context).setDark();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  InkWell(
                    onTap: () async {
                      BlocProvider.of<SignupCubit>(context)
                          .updateField(context, field: "phone", data: "");
                      BlocProvider.of<SignupCubit>(context)
                          .updateField(context, field: "motdepasse", data: "");
                      BlocProvider.of<SignupCubit>(context)
                          .updateField(context, field: "nom", data: "");

                      BlocProvider.of<SignupCubit>(context)
                          .updateField(context, field: "postnom", data: "");
                      BlocProvider.of<SignupCubit>(context)
                          .updateField(context, field: "prenom", data: "");
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                    },
                    child: CardSetting(
                      title: "Se déconnecter",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
