// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/sites/widgets/detailsite.dart';

class CardSites extends StatefulWidget {
  final Map? data;
  const CardSites({super.key, this.data});

  @override
  State<CardSites> createState() => _CardSitesState();
}

class _CardSitesState extends State<CardSites> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailSitesScreen(data: widget.data)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 160,
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
                    "${widget.data!["name"]}",
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.myBrown,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    Icons.location_city_outlined,
                    color: MyColors.myBrown,
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
                    "Localisation",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("${widget.data!["location"]}",
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
                    "Téléphone",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11),
                  ),
                  Text("${widget.data!["contacts"]}",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11)),
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
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11)),
                  Text("${widget.data!["updated_at"]}",
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

