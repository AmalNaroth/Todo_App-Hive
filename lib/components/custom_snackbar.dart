import 'package:flutter/material.dart';
import 'package:todo_hive/components/custom_text_widget.dart';

void customSnackBar(String text,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CustomTextWidget(text)));
}