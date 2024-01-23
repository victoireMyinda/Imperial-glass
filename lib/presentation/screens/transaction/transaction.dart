import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/presentation/screens/transaction/widgets/loadTransaction.dart';
import 'package:icecream_service/presentation/widgets/imageview.dart';
import 'widgets/cardTransaction.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TransactionScreen extends StatefulWidget {
  TransactionScreen({Key? key, required this.backNavigation}) : super(key: key);
  bool backNavigation = false;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
            "Dernières transactions",
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
          child: lengthTransaction == 0
              ? Column(
                children: [
                  Lottie.asset("assets/images/last-transaction.json", height: 500),
                  Text("Vous n'avez pas des transactions")
                ],
              )
              : SingleChildScrollView(
                child: Container(
                    // color: Colors.grey.withOpacity(0.1),
                    padding: EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height,
                    // padding: const EdgeInsets.only(top: 10.0),
                    width: MediaQuery.of(context).size.width,

                    child: isLoading == false
                        ? Column(
                            children: [
                              loadTransaction(),
                              loadTransaction(),
                              loadTransaction(),
                              loadTransaction(),
                              loadTransaction(),
                            ],
                          )
                        : ListView.builder(
                            itemCount: transactions.length ?? [],
                            itemBuilder: (BuildContext context, int index) {
                              if (lengthTransaction == 0) {
                                return Lottie.asset("assets/images/last-transaction.json",
                                    height: 100);
                              } else {
                                return CardTransaction(
                                    transactions: transactions[index]);
                              }
                            },
                          ),
                  ),
              ),
        ));
  }
}
