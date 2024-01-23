// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/signup/signup-step3.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:icecream_service/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:icecream_service/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:icecream_service/routestack.dart';
import 'package:icecream_service/theme.dart';
import 'package:http/http.dart' as http;

class TransAcademiaYesNoDialog {
  static show(BuildContext context, String? text) {
    showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          Widget okButton = TextButton(
            child: const Text(
              "NON",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );

          Widget nopeButton = TextButton(
            child: const Text("OUI"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupStep3(backNavigation: false,)),
              );
            },
          );

          AlertDialog alert = AlertDialog(
            // title: const Text("Leave"),
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
            content: Text(text.toString()),
            actions: [
              nopeButton,
              okButton,
            ],
          );
          return alert;
        });
  }
}
