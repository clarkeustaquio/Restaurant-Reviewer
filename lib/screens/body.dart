import 'package:flutter/material.dart';
import 'package:restaurant_quiz/database_connection/review_connection.dart';

import 'package:restaurant_quiz/screens/navigations/restaurant_form.dart';
import 'package:restaurant_quiz/screens/navigations/reviewer_form.dart';
import 'package:restaurant_quiz/screens/navigations/review_form.dart';
import 'package:restaurant_quiz/screens/navigations/view_detail.dart';


class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>{
  final ReviewConnection reviewConnection = ReviewConnection();
  bool isDone = false;
  ValueNotifier reviewList = ValueNotifier(List());
  List<dynamic> displayReview = List();

  Future<void> getReviewList() async{
    await reviewConnection.openReviewConnection();
    if(reviewConnection.database != null){
      List reviews;
      try{
        reviews = await reviewConnection.getReviewList();
        setState(() {
          for(var review in reviews){
            displayReview.add(review);
          }
          isDone = true;
        });
      }on Exception catch(_){}
    }
  }

  @override
  void initState(){
    super.initState();
    // if(!isDone)
    //   getReviewList();
  }

  Future<void> changeList() async{
    await reviewConnection.openReviewConnection();
    if(reviewConnection.database != null){
      List<dynamic> holder = List<dynamic>();
      List reviews = await reviewConnection.getReviewList();
      
      for(var review in reviews){
        holder.add(review);
      }
      setState(() {
        reviewList.value = holder;
        displayReview = holder;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Logo
        Container(
          width: double.infinity,
          height: 300.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/restaurant/restaurant_chef.png'),
            )
          ),
        ),
        Container(
          width: double.infinity,
          height: 200.0,
          child: ListView(
            children: [
              for(var review in displayReview)
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  width: double.infinity,
                  child: ListTile(
                    title: Text(review.restaurantNameReview),
                    subtitle: Text(review.reviewerNameReview),
                    leading: Icon(Icons.account_circle),
                    trailing: FlatButton(
                      child: Text('View'),
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => View(review)),
                        );
                      },
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                ),

              Divider(),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left:15.0, right:15.0),
          child: RaisedButton(
            color: Colors.blue,
            child: Text(
              'Add Restaurant',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RestaurantForm(),
                ),
              );
            }
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left:15.0, right:15.0),
          child: RaisedButton(
            color: Colors.blue,
            child: Text(
              'Add Reviewer',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewerForm(),
                ),
              );
            }
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left:15.0, right:15.0),
          child: RaisedButton(
            child: Text(
              'Add Review',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewForm(reviewList, displayReview),
                ),
              ).then((value){
                changeList();
              });
            }
          ),
        ),
      ],
    );
  }
}