import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/widget/cardlistPlaceholder.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/commande/commande.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/mesventes/widget/cardvente.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/versement/ventedujour.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/appbarkelasi.dart';


// ignore: must_be_immutable
class MesVentes extends StatefulWidget {
  final bool? backNavigation;
  const MesVentes({Key? key, this.backNavigation}) : super(key: key);

  @override
  State<MesVentes> createState() => _MesVentesState();
}

class _MesVentesState extends State<MesVentes> {

 List? dataOperation = [];
  bool isLoading = true;
  int dataOperationLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idAgent = prefs.getString("id");
    Map? response =
        await SignUpRepository.getOperationsByIdAgent(idAgent);
    List? operations = response["data"];

    // print(response["data"]);
    setState(() {
      dataOperation = operations;
      isLoading = false;
      dataOperationLength = operations!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(0.1),
          appBar: AppBarKelasi(
            title: "Historique de ventes",
            leftIcon: "assets/icons/rowback-icon.svg",
            visibleAvatar: false,
            sizeleftIcon: 12,
            backgroundColor: Colors.white,
            color: MyColors.myBrown,
            onTapFunction: () => Navigator.of(context).pop(),
          ),
            floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>   VenteDuJourScreen(backNavigation: false,)),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
          body: SafeArea(
            child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Toutes mes ventes",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      dataOperation!.length.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              isLoading == true
                  ? Flexible(
                     
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return const CardProduitPlaceholder();
                        },
                      ),
                    )
                  : dataOperationLength == 0
                      ? Column(
                          children: [
                            Lottie.asset(
                                "assets/images/last-transaction.json",
                                height: 200),
                            const Text("Aucune vente enregistrée.")
                          ],
                        )
                      : Flexible(
                         
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataOperation!
                                  .length, 
                              itemBuilder: (BuildContext context, int index) {
                                return CardVentes(data: dataOperation![index]);
                              }),
                        ) 
            ],
          ),
          )),
    );
  }
}
