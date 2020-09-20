import 'package:flutter/foundation.dart';

class RestaurantModel{
  final String restaurantName;

  RestaurantModel({@required this.restaurantName});

  Map<String, dynamic> mapRestaurant(){
    return {
      'restaurantName': restaurantName,
    };
  }
}

class ReviewerModel{
  final String reviewerName;

  ReviewerModel({@required this.reviewerName});
  
  Map<String, dynamic> mapReviewer(){
    return {
      'reviewerName': reviewerName,
    };
  }
}

class ReviewModel{
  final String reviewerNameReview;
  final String restaurantNameReview;
  final String ratingReview;
  final String commentReview;

  ReviewModel({
    @required this.reviewerNameReview,
    @required this.restaurantNameReview,
    @required this.ratingReview,
    @required this.commentReview,
  });

  Map<String, dynamic> mapReview(){
    return {
      'reviewerNameReview': reviewerNameReview,
      'restaurantNameReview': restaurantNameReview,
      'ratingReview': ratingReview,
      'commentReview': commentReview,
    };
  }
}