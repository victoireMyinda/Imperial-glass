import 'package:flutter/material.dart';
import 'package:icecream_service/constants/my_colors.dart';
import '../../../widgets/appbarkelasi.dart';

class MesBonusScreen extends StatefulWidget {
  final bool? backNavigation;
  const MesBonusScreen({Key? key, this.backNavigation}) : super(key: key);

  @override
  State<MesBonusScreen> createState() => _MesBonusScreenState();
}

class _MesBonusScreenState extends State<MesBonusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Tous mes bonus",
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
              padding: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Date de vente",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.myBrown),
                        ),
                        Text(
                          "Qte",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.myBrown),
                        ),
                        Text(
                          "Montant vendu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.myBrown),
                        ),
                        Text(
                          "Bonus",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.myBrown),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "12/01/2024",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "100 L",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "50000 FC",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          "1000 FC",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                  
                    const SizedBox(height: 30),
                    RotationTransition(
                      turns: _animation,
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: MyColors.myWhite,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 225, 225, 225)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Bonus généré : ",
                              style: TextStyle(
                                color: MyColors.myBrown,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "50.000 FC",
                              style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
