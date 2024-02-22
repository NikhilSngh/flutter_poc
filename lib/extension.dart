import 'package:flutter/material.dart';
import 'package:flutter_poc/constant/app_padding_margin_constants.dart';

extension ShowLoader on BuildContext {
  void showLoader(){
    AlertDialog alert=AlertDialog(
      content:  Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left:AppPaddingMarginConstant.extraSmall),child:Text("Please Wait..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:this,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}