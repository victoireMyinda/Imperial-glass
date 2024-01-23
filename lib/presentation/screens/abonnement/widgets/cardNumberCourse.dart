import 'package:flutter/material.dart';
import 'package:icecream_service/theme.dart';

class CardNumberOfCourse extends StatefulWidget {
  const CardNumberOfCourse({super.key});

  @override
  State<CardNumberOfCourse> createState() => _CardNumberOfCourseState();
}

class _CardNumberOfCourseState extends State<CardNumberOfCourse> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20.0),
           gradient: const LinearGradient(
    colors: [
      Colors.cyan,
      Colors.indigo,
    ],
  ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,           
                children: const [
                  Text("Nombre de courses", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                  ),),
                  Text("6", style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w500
                  ),),

                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text("Voir plus", style: TextStyle(color:primaryColor, fontWeight: FontWeight.bold),),

              ),
            )
          ],
        ),
    );
  }
}