import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CardTransaction extends StatefulWidget {
  dynamic transactions;
  CardTransaction( {super.key, required this.transactions});


  @override
  State<CardTransaction> createState() => _CardTransactionState();
}

class _CardTransactionState extends State<CardTransaction> {
  var amount, amountNumber ;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = double.parse(widget.transactions['Montant']);
    amountNumber = amount.toInt();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.white,
        // color: AdaptiveTheme.of(context).brightness,
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("icon"),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/menu-abonnement-trans.svg",
                    width: 20.0,
                  ),
                  const SizedBox(
                    width: 9.0,
                  ),
                  Text(
                     widget.transactions['Type abonnement'],
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Text(
                widget.transactions['Date'],
                style: const TextStyle(color: Colors.grey,
                fontSize: 9),

              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              widget.transactions['Type abonnement'] == "Prelevement"?const Text("Pour la carte"):Text("Pour  ${widget.transactions['Duree_abonnement']}  jour(s) "),
              Row(
                children: [
                  Text("$amountNumber"),
                  Text(amountNumber > 375 ? " FC":" \$"),
                ],
              )
            ],
          )

        ],
      ),
    );
  }
}
