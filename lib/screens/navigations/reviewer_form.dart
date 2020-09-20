import 'package:flutter/material.dart';
import 'package:restaurant_quiz/models/main_model.dart';
import 'package:restaurant_quiz/database_connection/connection.dart';

class ReviewerForm extends StatefulWidget{
  @override
  _ReviewerFormState createState() => _ReviewerFormState();
}

class _ReviewerFormState extends State<ReviewerForm>{
  final Connection connection = Connection();
  final TextEditingController reviewerName = TextEditingController();

  @override
  void initState(){
    super.initState();
    connection.createRestaurant();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Reviewer Form')),
      body: BodyForm(
        reviewerName: reviewerName,
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
              onPressed: () async{
                ReviewerModel reviewerModel = ReviewerModel(reviewerName: reviewerName.text);
                await connection.addReviewer(reviewerModel);
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
  final TextEditingController reviewerName;
  BodyForm({@required this.reviewerName});
  @override
  _BodyFormState createState() => _BodyFormState(reviewerName: reviewerName);
}

class _BodyFormState extends State<BodyForm>{
  final TextEditingController reviewerName;

  _BodyFormState({@required this.reviewerName});
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
                labelText: 'Reviewer Name',
              ),
              controller: reviewerName,
            ),
          ),
        ],
      ),
    );
  }
}