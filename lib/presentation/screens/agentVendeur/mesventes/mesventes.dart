import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/mescommandes/widget/cardcommande.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/mesventes/widget/cardvente.dart';
import '../../../widgets/appbarkelasi.dart';

// ignore: must_be_immutable
class MesVentesScreen extends StatefulWidget {
  final bool? backNavigation;
  const MesVentesScreen({Key? key, this.backNavigation}) : super(key: key);

  @override
  State<MesVentesScreen> createState() => _MesVentesScreenState();
}

class _MesVentesScreenState extends State<MesVentesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(0.1),
          appBar: AppBarKelasi(
            title: "Mes ventes",
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
                    CardVentes(),
                    CardVentes(),
                    CardVentes(),
                    CardVentes(),
                    CardVentes()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
