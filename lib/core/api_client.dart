import 'package:dio/dio.dart';
import 'package:restaurant_api/model/restaurant.dart';
import 'package:restaurant_api/model/restaurant_detail.dart';
import 'package:restaurant_api/util/constant.dart';

class ApiClient {
  final Dio _dio = Dio();
  Future<RestaurantResult> getAllRestaurant() async {
    try {
      Response response = await _dio.get('$baseUrl/list');
      return RestaurantResult.fromJson(response.data);
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<RestaurantDetailResult> getDetailRestaurant(
      String restaurantId) async {
    try {
      Response response = await _dio.get('$baseUrl/detail/$restaurantId');
      return RestaurantDetailResult.fromJson(response.data);
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
