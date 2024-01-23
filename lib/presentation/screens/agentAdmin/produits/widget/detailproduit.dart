import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/signupproduit.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';


class DetailProduit extends StatefulWidget {
  DetailProduit({
    super.key,
  });

  @override
  State<DetailProduit> createState() => _DetailProduitState();
}

class _DetailProduitState extends State<DetailProduit> {
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
    String? idParent = prefs.getString("parentId");
    Map? response =
        await SignUpRepository.getEnfantsDuParent(idParent.toString());
    List? recorded = response["data"]["recorded"];

    print(response["data"]);
    setState(() {
      dataStudent = recorded;
      isLoading = false;
      dataStudentLength = recorded!.length;
      dataStudent = recorded.reversed.toList(); // Inversion de l'ordre
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Detail produit",
          leftIcon: "assets/icons/rowback-icon.svg",
          sizeleftIcon: 11,
          onTapFunction: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/icon.png'),
                        fit: BoxFit.cover, 
                      ),
                      border: Border.all(color: MyColors.myBrown, width: 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.grey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Glace à creme",
                            style: TextStyle(
                              fontSize: 20,
                              color: MyColors.myBrown,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.delete_outlined,
                                color: MyColors.myBrown,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupProduit()),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: MyColors.myBrown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Nature",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text("liquide",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Quantité",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("200 Litres",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Quantité disponible",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("10 Litres",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Prix",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("500 fc /Litre",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Date de mise à jour",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("15/05/1997",
                              style: TextStyle(fontWeight: FontWeight.w300))
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Column(
                          children: const [
                            Text("Statut produit : "),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Votre quantité restanre est faible. Vueillez vous approvisonner",
                              style: TextStyle(
                                  color: MyColors.myBrown, fontSize: 15),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
