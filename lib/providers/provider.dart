import 'package:flutter/material.dart';

import '../core/api_client.dart';
import '../model/restaurant.dart';
import '../model/restaurant_detail.dart';
import '../model/search.dart';

class DataProvider with ChangeNotifier {
  final ApiClient apiClient; // Declare a final UserRepository object
  DataProvider({required this.apiClient});

  late RestaurantResult _listRestaurant;
  late SearchResult _searchResult;
  late RestaurantDetailResult _detailRestaurant;

  bool _loading = false;
  final ApiClient _apiClient = ApiClient();
  String _errorMessage = '';

  RestaurantResult get listRestaurant => _listRestaurant;
  SearchResult get searchResult => _searchResult;
  RestaurantDetailResult get detailRestaurant => _detailRestaurant;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  Future getAllRestaurant() async {
    _loading = true;
    try {
      _listRestaurant = await _apiClient.getAllRestaurant();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future search(String query) async {
    _loading = true;
    try {
      _searchResult = await _apiClient.search(query);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future getRestaurantDetail(String restaurantId) async {
    _loading = true;
    try {
      _detailRestaurant = await _apiClient.getDetailRestaurant(restaurantId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
