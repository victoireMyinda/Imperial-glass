import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:url_launcher/url_launcher.dart';

class RefreshCheck extends StatefulWidget {
  final String? text;
  final String? icon;
  const RefreshCheck({Key? key, this.icon, this.text}) : super(key: key);

  @override
  _RefreshCheckState createState() => _RefreshCheckState();
}

class _RefreshCheckState extends State<RefreshCheck> {
  var androidState;
  var iosState;

  // final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=com.imperial.cream');
  final Uri _url = Uri.parse('market://details?id=com.imperial.cream');

  // final Uri _urlIOS = Uri.parse('itms-apps://itunes.apple.com/cd/app/id1548263651?mt=8');
  final Uri _urlIOS = Uri.parse('https://itunes.apple.com/cd/app/id6447296971?mt=8');

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

  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
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
                        return Lottie.asset(state.field!['iconVersion'].toString(),
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
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
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
                                title: "Mettre à jour votre profil"),
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
