// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnect();
  }

  @override
  void dispose() {
    super.dispose();
  }


  checkConnect() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var nom = prefs.getString('nom');
    var postnom = prefs.getString('postnom');
    var prenom = prefs.getString('prenom');

    Future.delayed(const Duration(seconds: 5)).then((val) {
      if (id == null) {    
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      } else {
        BlocProvider.of<SignupCubit>(context)
            .updateField(context, field: "nom", data: nom);
        BlocProvider.of<SignupCubit>(context)
            .updateField(context, field: "postnom", data: postnom);
        BlocProvider.of<SignupCubit>(context)
            .updateField(context, field: "prenom", data: prenom);
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/login', (Route<dynamic> route) => false);
      }
    });
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
              Image.asset(
                'assets/images/icegif.gif',
                width: 300.0,
                height: 300.0,
                // fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 80.0,
              ),
              Lottie.asset(
                // 'assets/images/loader-trans.json',
                'assets/images/load3.json',
               height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
