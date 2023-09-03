import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/view/editing_screen.dart';
import 'package:todo_hive/view/home_screen.dart';
import 'package:todo_hive/view/splash_screen.dart';
import 'package:todo_hive/viewmodels/splash_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider(),),
      ],
      child: MaterialApp(
        title: "Todo-Hive",
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey
        ),
        routes: {
          '/home' : (context)=> HomeScreen(),
          '/splash' : (context)=> const SplashScreen(),
          '/editScreen' : (context)=>  EditScreen(),
        },
      ),
    );
  }
}