// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/widgets/detailsite.dart';

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
              // builder: (context) => DetailEnfant(data: widget.data)),
              builder: (context) => DetailSitesScreen()),
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
                    "Site de masina",
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
                    "Adresse",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                  Text("10, ACP/Sans-fils",
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
                    "Agent affecté",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11),
                  ),
                  Text("Victoire myinda",
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
                  Text("15/05/1997",
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



// Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           height: 100,
//           // width: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 widget.data!["photo"] == null
//                     ? SvgPicture.asset(
//                         "assets/icons/avatarkelasi.svg",
//                         width: 50,
//                         color: kelasiColor,
//                       )
//                     : ImageViewerWidget(
//                         url:
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgXTbddKsgVA1ETOzRz4Kz9Ap-JtAZfCGGXA&usqp=CAU",
//                         width: 55,
//                         height: 55,
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                       ),
//               ]),
//               const Spacer(),
//               Column(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 115,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "${widget.data!["nom"]} ${widget.data!["postnom"]} ${widget.data!["prenom"]}  ",
//                           style: TextStyle( fontWeight: FontWeight.bold, fontSize: 11),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           decoration: const BoxDecoration(
//                             color: Color.fromARGB(255, 237, 236, 236),
//                             borderRadius: BorderRadius.all(Radius.circular(25)),
//                           ),
//                           child: const Text("Abonné",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.red,
//                                   fontSize: 11)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 115,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("College st.theophile",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400, fontSize: 11)),
//                         BlocBuilder<SignupCubit, SignupState>(
//                           builder: (context, state) {
//                             return Text(
//                               "Réf : ${state.field!["prenom"]} ${state.field!["nom"]}",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 11),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     height: 1,
//                     width: MediaQuery.of(context).size.width - 115,
//                     color: Colors.grey.shade300,
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 115,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(widget.data!["created_at"].toString(),
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400, fontSize: 11)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
