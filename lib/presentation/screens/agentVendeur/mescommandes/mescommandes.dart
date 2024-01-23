import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/mescommandes/widget/cardcommande.dart';
import '../../../widgets/appbarkelasi.dart';


// ignore: must_be_immutable
class MesCommandesScreen extends StatefulWidget {
  final bool? backNavigation;
  const MesCommandesScreen({Key? key, this.backNavigation}) : super(key: key);

  @override
  State<MesCommandesScreen> createState() => _MesCommandesScreenState();
}

class _MesCommandesScreenState extends State<MesCommandesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(0.1),
          appBar: AppBarKelasi(
            title: "Mes commandes",
            leftIcon: "assets/icons/rowback-icon.svg",
            visibleAvatar: false,
            sizeleftIcon: 12,
            backgroundColor: Colors.white,
            color: MyColors.myBrown,
            onTapFunction: () => Navigator.of(context).pop(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.grey.withOpacity(0.1),
                padding: const EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text("Notification"),
                   CardCommandes(),
                   CardCommandes(),
                   CardCommandes(),
                   CardCommandes(),
                   CardCommandes(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
