import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/presentation/screens/transaction/widgets/loadTransaction.dart';
import 'package:icecream_service/presentation/widgets/imageview.dart';
import 'widgets/cardTransaction.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TrajectoireScreen extends StatefulWidget {
  TrajectoireScreen({Key? key, required this.backNavigation}) : super(key: key);
  bool backNavigation = false;

  @override
  State<TrajectoireScreen> createState() => _TrajectoireScreenState();
}

class _TrajectoireScreenState extends State<TrajectoireScreen> {
  dynamic transactions;
  bool isLoading = false;
  int? lengthTransaction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransaction();
  }

  void getTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.getString('code'));

    await http.post(Uri.parse(
        // "https://api.trans-academia.cd/Trans_countLastCours.php"
        "https://tag.trans-academia.cd/API_dernieres_transactions.php"), body: {
      // 'IDetudiant': "STDTAC20230216051BBIEVL320367"
      'IDetudiant': prefs.getString('code')
    }).then((response) {
      var data = json.decode(response.body);
      int status;
      print(data['donnees']);
      status = data['status'];
      if (status == 200) {
        transactions = data['donnees'];
        setState(() {
          isLoading = true;
          lengthTransaction = transactions.length;
        });
        print(lengthTransaction);
      } else {
        transactions = [];
        setState(() {
          isLoading = true;
          lengthTransaction = transactions.length;
        });
        print(lengthTransaction);
        if (kDebugMode) {
          print('ok');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey.withOpacity(0.1),
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
            "Trajectoire",
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
            child: Column(
          children: [
            Lottie.asset("assets/images/maps.json", height: 400),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    child: Text(
                      "Cher(e) ${state.field!["prenom"]}, Nous sommes ravis de vous annoncer que notre nouveau produit sera bientôt disponible ! 👋🏽",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        )));
  }
}
