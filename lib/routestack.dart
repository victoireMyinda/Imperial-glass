import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/commande/commande.dart';
import 'package:icecream_service/presentation/screens/agentVendeur/versement/ventedujour.dart';
import 'package:icecream_service/presentation/screens/home/home_screen.dart';
import 'package:icecream_service/presentation/screens/setting/setting.dart';
import 'package:icecream_service/sizeconfig.dart';
import 'package:icecream_service/theme.dart';

class RouteStack extends StatefulWidget {
  const RouteStack({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RouteStackState createState() => _RouteStackState();
}

class _RouteStackState extends State<RouteStack>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ignore: prefer_final_fields
  List<Widget> _screens = [
    const HomeScreen(),
    const CommandeDuJourScreen(),
    const VenteDuJourScreen(),
    SettingScreen(backNavigation: false)
  ];

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    super.build(context);
    return Scaffold(
        // backgroundColor: const Color(0xFFFFFFFF),
        body: PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar:
            bottomNavigationBar(_selectedIndex, _onItemTapped, context));
  }

  @override
  bool get wantKeepAlive => true;
}

Widget bottomNavigationBar(_selectedIndex, _onItemTapped, context) {
  return Container(
    // color: Colors.grey.withOpacity(0.1),
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    child: ClipRRect(
      // borderRadius: const BorderRadius.only(
      //   topRight: Radius.circular(30),
      //   topLeft: Radius.circular(30),
      //   bottomLeft: Radius.circular(30),
      //   bottomRight: Radius.circular(30),
      // ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: const Color(0xFFffffff),
          backgroundColor: Theme.of(context).accentColor,
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
                label: "Accueil",
                icon: SvgPicture.asset("assets/icons/accueil-trans-grey.svg",
                    width: 20,
                    color: _selectedIndex == 0 ? Colors.brown : null)),
            BottomNavigationBarItem(
                label: "Commande",
                icon: SvgPicture.asset("assets/icons/bus-fret.svg",
                    width: 20,
                    color: _selectedIndex == 1 ? Colors.brown : null)),
            BottomNavigationBarItem(
                label: "Versement",
                // icon: Icon(Icons.add_circle_outline, size: 40,color: Colors.grey.withOpacity(0.5),)
                icon: SvgPicture.asset("assets/icons/inv.svg",
                    width: 20,
                    color: _selectedIndex == 2 ? Colors.brown : null)),
            BottomNavigationBarItem(
                label: "Réglage",
                // icon: Icon(Icons.add_circle_outline, size: 40,color: Colors.grey.withOpacity(0.5),)
                icon: SvgPicture.asset("assets/icons/setting-trans-grey.svg",
                    width: 20,
                    color: _selectedIndex == 3 ? Colors.brown : null)),
          ]),
    ),
  );
}
