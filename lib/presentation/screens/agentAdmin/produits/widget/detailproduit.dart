import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/produits/signupproduit.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';

class DetailProduit extends StatefulWidget {
  final Map? data;
  DetailProduit({super.key, required this.data});

  @override
  State<DetailProduit> createState() => _DetailProduitState();
}

class _DetailProduitState extends State<DetailProduit> {
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
                          Text(
                            "${widget.data!["description"]}",
                            style: const TextStyle(
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
                        children: [
                          const Text(
                            "Volume",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text("${widget.data!["volume"]}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300)),
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
                        children: [
                          const Text("Prix unitaire",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["unit_price"]} (CDF)",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300)),
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
                        children: [
                          const Text("Quantité disponible",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["unit_quatity"]}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300)),
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
                        children: [
                          const Text("Date de mise à jour",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["updated_at"]}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300))
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Column(
                          children: [
                            const Text("Statut stock produit : "),
                            const SizedBox(
                              height: 30,
                            ),
                            widget.data!["unit_quatity"] <= 1
                                ? const Text(
                                    "Votre stock est faible. Veuillez vous approvisionner.",
                                    style: TextStyle(
                                        color: MyColors.myBrown, fontSize: 15),
                                  )
                                : const Text(
                                    "Votre stock est suffisant.",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
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
