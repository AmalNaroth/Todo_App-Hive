import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/utils/constant.dart';
import 'package:todo_hive/viewmodels/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashProvider>().callNextScreen(context);
    return Scaffold(
      backgroundColor: splashBg,
      body: Center(child: Image.asset("assets/images/todo_splash.png"),),
    );
  }
}