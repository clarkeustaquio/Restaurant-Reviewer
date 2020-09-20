import 'package:flutter/material.dart';
import 'package:restaurant_quiz/models/main_model.dart';
import 'package:restaurant_quiz/database_connection/connection.dart';
import 'package:restaurant_quiz/database_connection/review_connection.dart';

class ReviewForm extends StatefulWidget{
  final displayReview;
  final ValueNotifier reviewList;
  ReviewForm(this.reviewList, this.displayReview);
  @override
  _ReviewFormState createState() => _ReviewFormState(reviewList, displayReview);
}

class _ReviewFormState extends State<ReviewForm>{
  List<dynamic> displayReview;
  List<dynamic> holder = List<dynamic>();
  final ValueNotifier reviewList;
  final Connection restaurantConnection = Connection();
  final Connection reviewerConnection = Connection();

  final ReviewConnection reviewConnection = ReviewConnection();

  List<String> restaurantList = List();
  List<String> reviewerList = List();

  String restaurantValue;
  String reviewerValue;
  String ratingValue;

  final ValueNotifier notifierRestaurant = ValueNotifier('');
  final ValueNotifier notifierReviewer = ValueNotifier('');
  final ValueNotifier notifierRating = ValueNotifier('1');


  final TextEditingController comment = TextEditingController();

  _ReviewFormState(this.reviewList, this.displayReview);

  Future _getRestaurant() async{
    await restaurantConnection.openRestaurantConnection();
    await reviewerConnection.openReviewerConnection();

    if(restaurantConnection.database != null){
      List restaurants = await restaurantConnection.getRestaurantList();
      setState((){
        for(var restaurant in restaurants)
          restaurantList.add(restaurant.restaurantName); 
      });
      print(restaurantList);
    }else{
      print('Access Denied');
    }

    if(reviewerConnection.database != null){
      List reviewers = await reviewerConnection.getReviewerList();
      setState(() {
        for(var reviewer in reviewers)
          reviewerList.add(reviewer.reviewerName);

          print(reviewerList);
      });
    }else{
      print('Access Denied');
    }
  }
  @override
  void initState() {
    super.initState();
    _getRestaurant();
    reviewConnection.createReview();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Review Form')),
      body: BodyForm(
        restaurantList: restaurantList,
        reviewerList: reviewerList,
        restaurantValue: restaurantValue,
        reviewerValue: reviewerValue,
        ratingValue: ratingValue,
        comment: comment,
        notifierRestaurant: notifierRestaurant,
        notifierReviewer: notifierReviewer,
        notifierRating: notifierRating,
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
                  if(reviewConnection.database != null){
                    ReviewModel reviewModel = ReviewModel(
                      reviewerNameReview: notifierReviewer.value, 
                      restaurantNameReview: notifierRestaurant.value, 
                      ratingReview: notifierRating.value, 
                      commentReview: comment.text,
                    );

                    await reviewConnection.addReview(reviewModel);
                    Navigator.pop(context);
                  }
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
  final List<String> restaurantList;
  final List<String> reviewerList;
  final String restaurantValue;
  final String reviewerValue;
  final String ratingValue;
  final TextEditingController comment;

  final ValueNotifier notifierRestaurant;
  final ValueNotifier notifierReviewer;
  final ValueNotifier notifierRating;
  
  BodyForm({
    @required this.restaurantList, 
    @required this.reviewerList,
    @required this.restaurantValue,
    @required this.reviewerValue,
    @required this.ratingValue,
    @required this.comment,
    @required this.notifierRestaurant,
    @required this.notifierReviewer,
    @required this.notifierRating,
  });
  @override
  _BodyFormState createState() => _BodyFormState(
    restaurantList: restaurantList,
    reviewerList: reviewerList,
    restaurantValue: restaurantValue,
    reviewerValue: reviewerValue,
    ratingValue: ratingValue,
    comment: comment,
    notifierRestaurant: notifierRestaurant,
    notifierReviewer: notifierReviewer,
    notifierRating: notifierRating,
  );
}

class _BodyFormState extends State<BodyForm>{
  final TextEditingController comment;
  
  // Restaurant
  List<String> restaurantList;
  String restaurantValue;

  // Reviewer
  List<String> reviewerList;
  String reviewerValue;

  // Rating
  List<int> ratingList;
  String ratingValue;

  final ValueNotifier notifierRestaurant;
  final ValueNotifier notifierReviewer;
  final ValueNotifier notifierRating;

  _BodyFormState({
    @required this.restaurantList, 
    @required this.reviewerList,
    @required this.restaurantValue,
    @required this.reviewerValue,
    @required this.ratingValue,
    @required this.comment,
    @required this.notifierRestaurant,
    @required this.notifierReviewer,
    @required this.notifierRating,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          //ReviewerName
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left:15.0, right: 20.0),
              child: DropdownButton(
                isExpanded: true,
                iconEnabledColor: Colors.blue,
                value: reviewerValue,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                hint: Text('Select Reviewer Name'),
                onChanged: (String newValueReviewer){
                  setState(() {
                    reviewerValue = newValueReviewer;
                    notifierReviewer.value = newValueReviewer;
                    print(reviewerValue);
                  });
                },
                items: reviewerList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          //RestaurantName 
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left:15.0, right: 20.0),
              child: DropdownButton(
                isExpanded: true,
                iconEnabledColor: Colors.blue,
                value: restaurantValue,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                hint: Text('Select Restaurant Name'),
                onChanged: (String newValueRestaurant){
                  setState(() {
                    restaurantValue = newValueRestaurant;
                    notifierRestaurant.value = newValueRestaurant;
                    print(restaurantValue);
                  });
                },
                items: restaurantList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          //Rating
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left:15.0, right: 20.0),
              child: DropdownButton(
                isExpanded: true,
                iconEnabledColor: Colors.blue,
                value: ratingValue,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                hint: Text('Select Rating'),
                onChanged: (String newValueRating){
                  setState(() {
                    ratingValue = newValueRating;
                    notifierRating.value = newValueRating;
                    print(ratingValue);
                  });
                },
                items: ['1', '2', '3', '4', '5'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.all(30.0),
            child: TextField(
              minLines: 1,
              maxLines: 3,
              controller: comment,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Comment',
              ),
            ),
          ),
        ],
      ),
    );
  }
}