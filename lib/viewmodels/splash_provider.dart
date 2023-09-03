import 'dart:async';

import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier{
  void callNextScreen(BuildContext context){
    Timer(const Duration(seconds: 3), () { 
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }
}