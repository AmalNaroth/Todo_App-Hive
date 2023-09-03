import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/viewmodels/home_provder.dart';

class SplashProvider extends ChangeNotifier{
  void callNextScreen(BuildContext context){
    context.read<HomeScreenProvider>().getValuesInDB();
    Timer(const Duration(seconds: 3), () { 
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }
}