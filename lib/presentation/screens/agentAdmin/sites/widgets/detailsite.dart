import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/sites/signupsite.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icecream_service/data/repository/signUp_repository.dart';

class DetailSitesScreen extends StatefulWidget {
  DetailSitesScreen({
    super.key,
  });

  @override
  State<DetailSitesScreen> createState() => _DetailSitesScreenState();
}

class _DetailSitesScreenState extends State<DetailSitesScreen> {
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
          title: "Detail site",
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/site.jpg'),
                        fit: BoxFit.cover,
                      ),
                   
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
                            "Site de masina",
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
                                            const SignupSite()),
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
                            "Province",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text("Kinshasa",
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
                          Text("Ville",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Kinshasa",
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
                          Text("Commune",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Masina",
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
                          Text("Quartier",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Sans-fils",
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
                          Text("Avenue",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("ACP",
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
                          Text("Numero",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("10",
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
                          Text("Agent affecté",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Victoire myinda",
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
