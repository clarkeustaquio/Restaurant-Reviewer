import 'package:flutter/material.dart';
import 'package:restaurant_quiz/screens/home.dart';

class Restaurant extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant',
      home: Home(),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Restaurant());
}