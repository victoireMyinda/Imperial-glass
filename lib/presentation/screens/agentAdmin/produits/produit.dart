import 'package:flutter/material.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/signupproduit.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/widget/cardlistPlaceholder.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/widget/cardproduit.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:lottie/lottie.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';

class ListProduitsScreen extends StatefulWidget {
  ListProduitsScreen({
    super.key,
  });

  @override
  State<ListProduitsScreen> createState() => _ListProduitsScreenState();
}

class _ListProduitsScreenState extends State<ListProduitsScreen> {
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? idParent = prefs.getString("parentId");
    Map? response =
        await SignUpRepository.gettAllProductCream();
    List? products = response["data"];

    // print(response["data"]);
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
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Mes Produits",
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
              MaterialPageRoute(
                  builder: (context) => const SignupProduit()),
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
                      "Produits enregistrés",
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
                            const Text("Aucun produit enregistré.")
                          ],
                        )
                      : Flexible(
                         
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataStudent!
                                  .length, 
                              itemBuilder: (BuildContext context, int index) {
                                return CardProduit(data: dataStudent![index]);
                              }),
                        ) 
            ],
          ),
        ),
      ),
    );
  }
}
