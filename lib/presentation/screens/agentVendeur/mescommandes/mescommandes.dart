import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/widget/cardlistPlaceholder.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/commande/commande.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/mescommandes/widget/cardcommande.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/appbarkelasi.dart';


// ignore: must_be_immutable
class MesCommandesScreen extends StatefulWidget {
  final bool? backNavigation;
  const MesCommandesScreen({Key? key, this.backNavigation}) : super(key: key);

  @override
  State<MesCommandesScreen> createState() => _MesCommandesScreenState();
}

class _MesCommandesScreenState extends State<MesCommandesScreen> {

 List? dataStudent = [];
  bool isLoading = true;
  int dataStudentLength = 0;

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
        await SignUpRepository.getCommandesByIdAgent(idAgent);
    List? products = response["data"];

    print(response["data"]);
    setState(() {
      dataStudent = products;
      isLoading = false;
      dataStudentLength = products!.length;
    });
  }

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
            floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  const CommandeDuJourScreen()),
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
                      "Commandes enregistrées",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      dataStudent!.length.toString(),
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
                  : dataStudentLength == 0
                      ? Column(
                          children: [
                            Lottie.asset(
                                "assets/images/last-transaction.json",
                                height: 200),
                            const Text("Aucune commande enregistrée.")
                          ],
                        )
                      : Flexible(
                         
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataStudent!
                                  .length, 
                              itemBuilder: (BuildContext context, int index) {
                                return CardCommandes(data: dataStudent![index]);
                              }),
                        ) 
            ],
          ),
          )),
    );
  }
}
