import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:restaurant_quiz/models/main_model.dart';

class Connection{
  Future<Database> database;

  void createRestaurant() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'restaurantDB.db'),
      onCreate: (db, version) async{
        await db.execute('CREATE TABLE restaurants(id INTEGER PRIMARY KEY AUTOINCREMENT, restaurantName TEXT)');
        await db.execute('CREATE TABLE reviewers(id INTEGER PRIMARY KEY AUTOINCREMENT, reviewerName TEXT)');
      },
      version: 2,
    );
    print('Restaurants Created');
  }

  Future<void> openRestaurantConnection() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'restaurantDB.db'),
      version: 1,
    );
    print('Connection Access - Restaurant');
  }

  Future<void> openReviewerConnection() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'restaurantDB.db'),
      version: 1,
    );
    print('Connection Access - Reviewer');
  }

  Future<void> addRestaurant(RestaurantModel restaurant) async{
    final Database db = await database;
    if(db != null){
      await db.insert(
        'restaurants',
        restaurant.mapRestaurant(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
      print('Added');
    }
  }

  Future<void> addReviewer(ReviewerModel reviewerModel) async{
    final Database db = await database;
    if(db != null){
      await db.insert(
        'reviewers',
        reviewerModel.mapReviewer(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Added');
    }
  }

  Future<List<RestaurantModel>> getRestaurantList() async{
    final Database db = await database;
    final List<Map<String, dynamic>> restaurantList = await db.query('restaurants');

    return List.generate(restaurantList.length, (index) {
        return RestaurantModel(
          restaurantName: restaurantList[index]['restaurantName'],
        );
      }
    );
  }

  Future<List<ReviewerModel>> getReviewerList() async{
    final Database db = await database;
    final List<Map<String, dynamic>> reviewerList = await db.query('reviewers');

    return List.generate(reviewerList.length, (index){
      return ReviewerModel(
        reviewerName: reviewerList[index]['reviewerName'],
      );
    });
  }
}