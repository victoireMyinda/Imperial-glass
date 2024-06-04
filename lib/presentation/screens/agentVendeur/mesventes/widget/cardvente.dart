// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';


class CardVentes extends StatefulWidget {
  final Map? data;
  const CardVentes({super.key, this.data});

  @override
  State<CardVentes> createState() => _CardVentesState();
}

class _CardVentesState extends State<CardVentes> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DetailSitesScreen(data: widget.data)),
      //   );
      // },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: MyColors.mylite),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.data!["operation_nature"]} | ${widget.data!["operation_reason"]}",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.myBrown,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    Icons.attach_money_outlined,
                    color: MyColors.myBrown,
                    size: 24,
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Site de vente",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["sale_site"]}",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantité vendue",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["total_quantity"]} ${widget.data!["unit_name"]}",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Somme totale vendue",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11),
                  ),
                  Text("${widget.data!["total_sum"]}  ${widget.data!["currency_name"]}",
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 11, color: Colors.brown)),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date de la vente",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11)),
                  Text("${widget.data!["created_at"]}",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

