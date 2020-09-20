import 'package:flutter/material.dart';
import 'package:restaurant_quiz/screens/body.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant')),
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}