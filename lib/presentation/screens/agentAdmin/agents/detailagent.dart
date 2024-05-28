import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/agents/signupagent/signupvendeurstep1.dart';
import 'package:icecream_service/presentation/widgets/appbarkelasi.dart';


class DetailAgentScreen extends StatefulWidget {
  Map? data;
  DetailAgentScreen({
    super.key, required this.data
  });

  @override
  State<DetailAgentScreen> createState() => _DetailAgentScreenState();
}

class _DetailAgentScreenState extends State<DetailAgentScreen> {
  
  // bool isLoading = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loadData();
  // }

  // loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? agentId = prefs.getString("id");
  //   Map? response =
  //       await SignUpRepository.getAgentById(agentId.toString());
  //   List? agentById = response["data"];

  //   // print(response["data"]);
  //   setState(() {
  //     dataAgentById = agentById;
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Detail agent",
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
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/avatarkelasi.svg",
                      color: MyColors.myBrown,
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
                            "${widget.data!["first_name"]} ${widget.data!["second_name"]}",
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
                                            const SingupVendeurStep1()),
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
                        children:  [
                          const Text("Téléphone",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["phone"]}",
                              style: const TextStyle(fontWeight: FontWeight.w300)),
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
                          Text("site affecté",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("Masina Sans-fils",
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
                        children: [
                          const Text("Grade",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["grade"]}",
                              style: const TextStyle(fontWeight: FontWeight.w300)),
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
                          const Text("Fonction",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["function"]}",
                              style: const TextStyle(fontWeight: FontWeight.w300)),
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
                        children:  [
                         const  Text("Mail",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          Text("${widget.data!["email"]}",
                              style: const TextStyle(fontWeight: FontWeight.w300)),
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
                          Text("${widget.data!["updated_at"]}"
                          ,
                              style: const TextStyle(fontWeight: FontWeight.w300))
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
