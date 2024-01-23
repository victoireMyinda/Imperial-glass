import 'package:flutter/material.dart';

class CustomeAppBar extends StatefulWidget {
  final String? image;
  final String? textTitle;
  final String? color;
  const CustomeAppBar({super.key, this.image, this.textTitle, this.color});

  @override
  State<CustomeAppBar> createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff204F97),
            ),
          ),
          Text(
            widget.textTitle.toString(),
            style: const TextStyle(color: Color(0xff204F97), fontSize: 15),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.image.toString()),
          )
        ],
      ),
    );
  }
}
