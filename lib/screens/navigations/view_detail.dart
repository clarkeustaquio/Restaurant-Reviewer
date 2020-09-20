import 'package:flutter/material.dart';

class View extends StatelessWidget{
  final review;

  View(this.review);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('View Details')),
      body: Body(review),
      bottomSheet: Container(
        width: double.infinity,
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

class Body extends StatelessWidget{
  final review;
  Body(this.review);
  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: 500.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
          'Rating Representation',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i = 0; i < int.parse(review.ratingReview); i++)
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/review/rating_represent.png'),
                      )
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(
                'Restaurant Name: ${review.restaurantNameReview}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(
                'Reviewer Name: ${review.reviewerNameReview}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(
                'Rating: ${review.ratingReview}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(
                'Comment: ${review.commentReview}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}