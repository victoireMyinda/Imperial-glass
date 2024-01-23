import 'package:icecream_service/theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:icecream_service/utils/color.util.dart';

class LoadingDialog {
  static show(){
    BotToast.showCustomLoading(
      backgroundColor: Colors.black12,
      clickClose: false,
      toastBuilder: (func){
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
            boxShadow: [BoxShadow(blurRadius: 50, color: Colors.black12)]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    paarlColor
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
  static stop(){
    BotToast.closeAllLoading();
  }
}