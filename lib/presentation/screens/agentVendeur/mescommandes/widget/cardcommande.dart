// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/sites/widgets/detailsite.dart';

class CardCommandes extends StatefulWidget {
  final Map? data;
  const CardCommandes({super.key, this.data});

  @override
  State<CardCommandes> createState() => _CardCommandesState();
}

class _CardCommandesState extends State<CardCommandes> {
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
          height: 200,
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
               
                children: [
                  Text(
                    "${widget.data!["description"]}",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12,color: MyColors.myBrown,),
                  ),
                  
                ],
              ),
               Divider(
                thickness: 1,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "${widget.data!["estimated_price"]} Franc congolais",
              //       style: TextStyle(
              //           fontSize: 11,
                        
              //           fontWeight: FontWeight.bold),
              //     ),
              //     Icon(
              //       Icons.shopping_cart_outlined,
              //       color: MyColors.myBrown,
              //     ),
              //   ],
              // ),
              // Divider(
              //   thickness: 1,
              // ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Prix total de la commande",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["estimated_price"]} FC", 
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 11)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Commandée",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["order_at"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Livrée",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["delivered_at"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Statut",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["status"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: widget.data!["status"] == "pending"
                              ? Colors.orange
                              : Colors.green)),
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
                  Text("Date de mise à jour",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 11)),
                  Text("${widget.data!["updated_at"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 11))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
