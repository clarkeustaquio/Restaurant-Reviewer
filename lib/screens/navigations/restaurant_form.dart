import 'package:flutter/material.dart';
import 'package:restaurant_quiz/models/main_model.dart';
import 'package:restaurant_quiz/database_connection/connection.dart';


class RestaurantForm extends StatefulWidget{
  @override
  _RestaurantFormState createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm>{
  final Connection connection = Connection();
  final TextEditingController restaurantName = TextEditingController();

  @override
  void initState(){
    super.initState();
    connection.createRestaurant();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Form')),
      body: BodyForm(
        restaurantName: restaurantName,
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                RestaurantModel restaurantModel = RestaurantModel(
                  restaurantName: restaurantName.text,
                );
                await connection.addRestaurant(restaurantModel);
                Navigator.pop(context);
              },
            ),
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Back',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class BodyForm extends StatefulWidget{
  final TextEditingController restaurantName;

  BodyForm({@required this.restaurantName});
  @override
  _BodyFormState createState() => _BodyFormState(restaurantName: restaurantName);
}

class _BodyFormState extends State<BodyForm>{
  final TextEditingController restaurantName;

  _BodyFormState({@required this.restaurantName});

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Restaurant Name',
              ),
              controller: restaurantName,
            ),
          ),
        ],
      ),
    );
  }
}