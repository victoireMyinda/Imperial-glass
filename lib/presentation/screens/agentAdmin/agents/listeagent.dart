import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/widget/cardagent.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/signupagent/signupvendeurstep1.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';

class ListeAgentsScreen extends StatefulWidget {
  ListeAgentsScreen({
    super.key,
  });

  @override
  State<ListeAgentsScreen> createState() => _ListeAgentsScreenState();
}

class _ListeAgentsScreenState extends State<ListeAgentsScreen> {
  // List? dataStudent = [];
  // bool isLoading = true;
  // int dataStudentLength = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadData();
  // }

  // loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? idParent = prefs.getString("parentId");
  //   Map? response =
  //       await SignUpRepository.getEnfantsDuParent(idParent.toString());
  //   List? recorded = response["data"]["recorded"];

  //   print(response["data"]);
  //   setState(() {
  //     dataStudent = recorded;
  //     isLoading = false;
  //     dataStudentLength = recorded!.length;
  //     dataStudent = recorded.reversed.toList(); // Inversion de l'ordre
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Tous mes agents",
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
                  builder: (context) => const SingupVendeurStep1()),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: MyColors.myBrown,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Nombre d'agents",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      // Text(
                      //   dataStudent!.length.toString(),
                      //   style: TextStyle(fontWeight: FontWeight.w500),
                      // ),
                      Text(
                        "6",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                // isLoading == true
                //     ? SizedBox(
                //         height: 400,
                //         child: ListView.builder(
                //           scrollDirection: Axis.vertical,
                //           itemCount: 3, // ou le nombre d'éléments que vous avez
                //           itemBuilder: (BuildContext context, int index) {
                //             return const CardListEnfantPlaceholder();
                //           },
                //         ),
                //       )
                //     : dataStudentLength == 0
                //         ? Column(
                //             children: [
                //               Lottie.asset(
                //                   "assets/images/last-transaction.json",
                //                   height: 200),
                //               const Text("Aucun enfant n'a été enregistré.")
                //             ],
                //           )
                //         : SizedBox(
                //             height: 400,
                //             child: ListView.builder(
                //                 scrollDirection: Axis.vertical,
                //                 itemCount: dataStudent!
                //                     .length, // ou le nombre d'éléments que vous avez
                //                 itemBuilder: (BuildContext context, int index) {
                //                   return CardListEnfant(
                //                       data: dataStudent![index]);
                //                 }),
                //           )
                const CartdAgent(),
                const CartdAgent(),
                const CartdAgent(),
                const CartdAgent(),
                const CartdAgent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
