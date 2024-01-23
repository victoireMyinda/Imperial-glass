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
      height: 100,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Course de la journée",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "6",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              alignment: Alignment.center,
              // height: 30,
              // width: 60,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.green),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Expire : 31/01/2023",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
