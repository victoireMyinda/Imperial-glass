import 'package:flutter/material.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/widget/cardlistPlaceholder.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/sites/signupsite.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/sites/widgets/cardsite.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';

class ListSitesScreen extends StatefulWidget {
  ListSitesScreen({
    super.key,
  });

  @override
  State<ListSitesScreen> createState() => _ListSitesScreenState();
}

class _ListSitesScreenState extends State<ListSitesScreen> {
  List? dataSite = [];
  bool isLoading = true;
  int dataSiteLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? idParent = prefs.getString("parentId");
    Map? response = await SignUpRepository.gettAllSIteCream();
    List? siteList = response["data"];

    // print(response["data"]);
    setState(() {
      dataSite = siteList;
      isLoading = false;
      dataSiteLength = siteList!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Tous les sites...",
          leftIcon: "assets/icons/rowback-icon.svg",
          sizeleftIcon: 11,
          onTapFunction: () {
            Navigator.of(context).pop();
          },
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupSite()),
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
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
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
                      "Sites enregistrés",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      dataSite!.length.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              isLoading == true
                  ? Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 3, // ou le nombre d'éléments que vous avez
                        itemBuilder: (BuildContext context, int index) {
                          return const CardProduitPlaceholder();
                        },
                      ),
                    )
                  : dataSiteLength == 0
                      ? Column(
                          children: [
                            Lottie.asset(
                                "assets/images/last-transaction.json",
                                height: 200),
                            const Text("Aucun site enregistré.")
                          ],
                        )
                      : Flexible(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataSite!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardSites(data: dataSite![index]);
                              }),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
