import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/modules/home/start_screen.dart';
import 'package:todoapp/shared/bloc_observer.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp()); //run the application insidethere is a widjet
}
// two main widjet
// stateless
// statful
//class MyApp
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }


}