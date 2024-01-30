import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icecream_service/constants/my_colors.dart';

class CardCommandes extends StatefulWidget {
  Map? data;
  CardCommandes({super.key, required this.data});

  @override
  State<CardCommandes> createState() => _CardCommandesState();
}

class _CardCommandesState extends State<CardCommandes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.data!["description"]}",
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.person_rounded,
                    size: 25.0,
                    color: MyColors.myBrown,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Victoire Myinda",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ],
              ),
              Text(
                "${widget.data!["order_at"]}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Livrée ",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "${widget.data!["delivered_at"]}",
                style: const TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 11),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Statut",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "${widget.data!["status"]}",
                style: const TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 11),
              )
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total en chiffre",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "${widget.data!["estimated_price"]}",
                style: const TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 11),
              )
            ],
          ),
        ],
      ),
    );
  }
}
