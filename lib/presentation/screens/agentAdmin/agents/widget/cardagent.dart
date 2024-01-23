// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/detailagent.dart';

class CartdAgent extends StatefulWidget {
  // final Map? data;
  const CartdAgent({super.key});

  @override
  State<CartdAgent> createState() => _CartdAgentState();
}

class _CartdAgentState extends State<CartdAgent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailAgentScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // widget.data!["photo"] == null
                //     ? SvgPicture.asset(
                //         "assets/icons/avatarkelasi.svg",
                //         width: 50,
                //         color: kelasiColor,
                //       ) :
                SvgPicture.asset(
                  "assets/icons/avatarkelasi.svg",
                  width: 50,
                  color: MyColors.myBrown,
                )
              ]),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   "${widget.data!["nom"]} ${widget.data!["postnom"]} ${widget.data!["prenom"]}  ",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 11),
                        // ),
                        Text(
                          "Victoire Myinda Tshiaponyi",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 237, 236, 236),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: const Text("Affecté",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.myBrown,
                                  fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("243816644420",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 11)),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return Text(
                              "Affecté à Masina sans-fils",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 11),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 115,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(widget.data!["created_at"].toString(),
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w400, fontSize: 11)),
                         Text("15/01/2024",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
