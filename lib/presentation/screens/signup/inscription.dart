
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
// import 'package:icecream_service/presentation/screens/login/login_screen.dart';
// import 'package:icecream_service/presentation/widgets/buttons/buttonTransAcademia.dart';
// import 'package:icecream_service/theme.dart';
// import 'package:toast/toast.dart';

// class Inscription extends StatefulWidget {
//   const Inscription({super.key});

//   @override
//   State<Inscription> createState() => _InscriptionState();
// }

// class _InscriptionState extends State<Inscription>
//     with SingleTickerProviderStateMixin {
//   TabController? tabController;
//   int activeIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(vsync: this, length: 2);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     tabController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     tabController!.addListener(() {
//       ToastContext().init(context);
//       if (tabController!.indexIsChanging) {
//         setState(() {
//           activeIndex = tabController!.index;
//           print(activeIndex);
//         });
//       }
//     });
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: SafeArea(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
//             child: Column(
//               children: [
//                 Container(
//                   height: 80,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(
//                               AdaptiveTheme.of(context).mode.name != "dark"
//                                   ? "assets/images/logo-kelasi.png"
//                                   : "assets/images/logo-kelasi.png"))),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "Etes-vous un étudiant ou parent ?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       "Veuillez choisir et cliquez sur <<",
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     Text(
//                       "suivant",
//                       style:
//                           TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       ">>",
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 TabBar(
//                   controller: tabController,
//                   indicatorColor: kelasiColor,
//                   tabs: [
//                     Tab(
//                         child: Text(
//                       "Étudiant",
//                       style: TextStyle(
//                         color: Theme.of(context).backgroundColor,
//                       ),
//                     )),
//                     Tab(
//                         child: Text(
//                       "Parent",
//                       style: TextStyle(
//                         color: Theme.of(context).backgroundColor,
//                       ),
//                     ))
//                   ],
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: tabController,
//                     children: const [
//                       Image(image: AssetImage("assets/images/tabkelasi1.png")),
//                       Image(image: AssetImage("assets/images/tabkelasi2.png"),),
//                     ],
//                   ),
//                 ),

//                 GestureDetector(
//                   onTap: () {
//                     BlocProvider.of<SignupCubit>(context).updateField(context,
//                         field: "kelasiActiveIndex", data: activeIndex.toString());
//                     if (activeIndex == 0) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LoginScreen()),
//                       );
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LoginKelasiScreen()),
//                       );
//                     }
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.0),
//                     child: ButtonTransAcademia(
//                       title: "Suivant",
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void showToast(String msg, {int? duration, int? gravity}) {
//     Toast.show(msg, duration: duration, gravity: gravity);
//   }
// }
