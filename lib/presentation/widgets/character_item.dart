// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:icecream_service/constants/my_colors.dart';
import 'package:icecream_service/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:icecream_service/data/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        //*Passing the specific character[item] as an argument
        onTap: () {
          Navigator.of(context)
              .pushNamed(characterDetailsScreen, arguments: character);
        },
        child: GridTile(
          //*The footer
          footer: Hero(
            tag: character.charId,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.6,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //*The GridTile main content
          child: Container(
            color: MyColors.myGrey,
            child: character.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    image: character.image,
                  )
                : Image.asset("assets/images/placeholder.jpg"),
          ),
        ),
      ),
    );
  }
}
