import 'package:flutter/foundation.dart';
import 'package:restaurant_api/model/restaurant.dart';

import '../core/db/db_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  late Restaurant _restaurantData;
  late DbHelper _dbHelper;

  List<Restaurant> get restaurant => _restaurant;
  Restaurant get restaurantData => _restaurantData;

  DbProvider() {
    _dbHelper = DbHelper();
    getAllFav();
  }

  Future<void> addFav(Restaurant restaurant) async {
    await _dbHelper.addToFavorite(restaurant);
    getAllFav();
  }

  void getAllFav() async {
    _restaurant = await _dbHelper.getAllFavoriteRestaurant();
    notifyListeners();
  }

  void getFavById(String id) async {
    _restaurantData = await _dbHelper.getFavById(id);
  }

  void deleteFav(int id) async {
    await _dbHelper.deleteFromFav(id);
    getAllFav();
  }
}
