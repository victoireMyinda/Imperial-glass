import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icecream_service/presentation/screens/agentAdmin/ventejournaliere/ventejournaliere.dart';

class AppBarKelasi extends StatefulWidget implements PreferredSizeWidget {
  final Color? color, backgroundColor;
  final String? leftIcon;
  final double? sizeleftIcon;
  final String title;
  final bool? visibleAvatar;
  final VoidCallback? onTapFunction;

  const AppBarKelasi({
    Key? key,
    this.color,
    this.leftIcon,
    required this.title,
    this.onTapFunction,
    this.sizeleftIcon,
    this.backgroundColor,
    this.visibleAvatar
  }) : super(key: key);

  @override
  _AppBarKelasiState createState() => _AppBarKelasiState();

  @override
  Size get preferredSize => const Size.fromHeight(50.0); // Ajustez la hauteur selon vos besoins
}

class _AppBarKelasiState extends State<AppBarKelasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.onTapFunction,
            child: SvgPicture.asset(
              widget.leftIcon.toString(),
              width: widget.sizeleftIcon,
               color: widget.color ?? Colors.brown,
            ),
          ),
          Text(
            widget.title.toString(),
            style: TextStyle(
              color: widget.color ?? Colors.brown,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          widget.visibleAvatar == false?
          Container():
          GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const NotificationScreen(),
            //     ),
            //   );
            // },
            child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 30,),
          ),
        ],
      ),
    );
  }
}

