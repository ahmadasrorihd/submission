import 'package:flutter/foundation.dart';
import 'package:restaurant_api/model/restaurant.dart';

import '../core/db/db_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  bool _restaurantData = false;
  late DbHelper _dbHelper;

  List<Restaurant> get restaurant => _restaurant;
  bool get restaurantData => _restaurantData;

  DbProvider() {
    _dbHelper = DbHelper();
    getAllFav();
  }

  Future<void> addFav(Restaurant restaurant) async {
    await _dbHelper.addToFavorite(restaurant);
    getFavById(restaurant.id);
    getAllFav();
  }

  void getAllFav() async {
    _restaurant = await _dbHelper.getAllFavoriteRestaurant();
    notifyListeners();
  }

  Future<void> getFavById(String id) async {
    _restaurantData = await _dbHelper.getFavById(id);
    notifyListeners();
  }

  void deleteFav(String id) async {
    await _dbHelper.deleteFromFav(id);
    getFavById(id);
    getAllFav();
  }
}
