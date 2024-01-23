import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionScreen extends StatefulWidget {
  final String? text;
  final String? icon;
  const VersionScreen({Key? key, this.icon, this.text}) : super(key: key);

  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  var androidState;
  var iosState;

  // final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=com.imperial.cream');
  final Uri _url = Uri.parse('market://details?id=com.imperial.cream');

  // final Uri _urlIOS = Uri.parse('itms-apps://itunes.apple.com/cd/app/id1548263651?mt=8');
  final Uri _urlIOS =
      Uri.parse('https://itunes.apple.com/cd/app/id6447296971?mt=8');

  Future<void> launchUrlSite() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> launchUrlSiteIOS() async {
    if (!await launchUrl(_urlIOS)) {
      throw Exception('Could not launch $_urlIOS');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkConnect();
    // checkVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // checkVersion() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String version = packageInfo.version;
  //   String buildNumber = packageInfo.buildNumber;

  //   print('build' + buildNumber);

  //   final response = await http
  //       .get(Uri.parse('https://api-bantou-store.vercel.app/api/v1/versions'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     print(data["android"]);

  //     androidState = data["android"];
  //     iosState = data["ios"];

  //     if (Platform.isIOS == true) {
  //       if (buildNumber != iosState) {
  //         // ignore: use_build_context_synchronously
  //         TransAcademiaDialogVersion.show(
  //             context,
  //             "Mettre à jour l'application sur Appstore",
  //             'Mise à jour',
  //             "assets/images/appstore.json");
  //         return;
  //       } else {
  //         print('ok');
  //         return;
  //       }
  //     }

  //     if (Platform.isIOS == false) {
  //       if (buildNumber != androidState) {
  //         // ignore: use_build_context_synchronously
  //         TransAcademiaDialogVersion.show(
  //             context,
  //             "Mettre à jour l'application sur playstore",
  //             'Mise à jour',
  //             "assets/images/playstore.json");
  //         // return;
  //       } else {
  //         print('ok');
  //       }
  //     }
  //   } else {
  //     print('error');
  //   }
  // }

  // checkConnect() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var id = prefs.getString('id');
  //   var nom = prefs.getString('nom');
  //   var postnom = prefs.getString('postnom');
  //   var prenom = prefs.getString('prenom');

  //   Future.delayed(const Duration(seconds: 5)).then((val) {
  //     if (id == null) {
  //       checkVersion();
  //       Navigator.of(context)
  //           .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  //     } else {
  //       checkVersion();
  //       BlocProvider.of<SignupCubit>(context)
  //           .updateField(context, field: "nom", data: nom);
  //       BlocProvider.of<SignupCubit>(context)
  //           .updateField(context, field: "postnom", data: postnom);
  //       BlocProvider.of<SignupCubit>(context)
  //           .updateField(context, field: "prenom", data: prenom);
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //           '/routestack', (Route<dynamic> route) => false);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final descriptionList =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AdaptiveTheme.of(context).mode.name == "dark"
                      ? Colors.black
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Lottie.asset(
                            state.field!['iconVersion'].toString(),
                            height: 100);
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Text(
                          state.field!["titreVersion"].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20,
                           fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                                        const SizedBox(
                      height: 20.0,
                    ),
                    // BlocBuilder<SignupCubit, SignupState>(
                    //   builder: (context, state) {
                    //     return Text(
                    //       "${descriptionList[0]}",
                    //       textAlign: TextAlign.center,
                    //       style: const TextStyle(fontSize: 16),
                    //     );
                    //   },
                    // ),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: descriptionList
                            .length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text( "${index+1}. ${descriptionList[index]}",
                                style: const TextStyle(
                                  fontSize: 17,
                                ),), 
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              if ((Platform.isIOS == false)) {
                                launchUrlSite();
                              } else {
                                launchUrlSiteIOS();
                              }
                            },
                            child: const ButtonTransAcademia(
                                title: "Mettre à jour"),
                          ),
                          const SizedBox(
                            height: 20,
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
    );
  }
}
