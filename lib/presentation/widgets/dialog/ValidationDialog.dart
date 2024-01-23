import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';


class ValidationDialog {
  static show(BuildContext context, String? text, Function? onClose) {
    showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 3/4,
                            // height: 100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: AdaptiveTheme.of(context).mode.name == "dark"
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(text.toString(), style: const TextStyle(
                                  fontSize: 16,
                                ),),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "currency", data: "");
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: const Text("OK"))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
