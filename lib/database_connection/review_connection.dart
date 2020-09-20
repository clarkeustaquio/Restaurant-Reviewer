import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:restaurant_quiz/models/main_model.dart';

class ReviewConnection {
  Future<Database> database;

  void createReview() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'reviewerDB.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE reviews(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            reviewerNameReview TEXT, 
            restaurantNameReview TEXT, 
            ratingReview TEXT, 
            commentReview TEXT)''',
        );
      },
      version: 1,
    );
    print('Review Created');
  }

  Future<void> openReviewConnection() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'reviewerDB.db'),
      version: 1,
    );
    print('Connection Access - Review');
  }

  Future<void> addReview(ReviewModel reviewModel) async{
    final Database db = await database;
    if(db != null){
      await db.insert(
        'reviews',
        reviewModel.mapReview(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Added');
    }
  }

  Future<List<ReviewModel>> getReviewList() async{
    final Database db = await database;
    final List<Map<String, dynamic>> reviewList = await db.query('reviews');

    return List.generate(reviewList.length, (index){
      return ReviewModel(
        reviewerNameReview: reviewList[index]['reviewerNameReview'], 
        restaurantNameReview: reviewList[index]['restaurantNameReview'], 
        ratingReview: reviewList[index]['ratingReview'], 
        commentReview: reviewList[index]['commentReview'],
      );
    });
  }
}