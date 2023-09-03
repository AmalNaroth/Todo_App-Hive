import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  String? text;
  FontWeight? fontWeight;
  double? fontSize;
  Color? fontColor;
   CustomTextWidget(this.text,{super.key,this.fontWeight,this.fontSize,this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(text!,style: TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight
    ),);
  }
}