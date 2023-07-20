import 'package:flutter/material.dart';
import 'package:restaurant_api/model/restaurant_detail.dart';

import '../core/api_client.dart';

class RestaurantDetail extends StatefulWidget {
  static String routeName = "/detail";
  final String restaurantId;

  const RestaurantDetail({super.key, required this.restaurantId});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final ApiClient _apiClient = ApiClient();
  Future<RestaurantDetailResult> getAllRestaurant() async {
    RestaurantDetailResult userRes =
        await _apiClient.getDetailRestaurant(widget.restaurantId);
    return userRes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<RestaurantDetailResult>(
          future: getAllRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (snapshot.data!.error) {
                return const Text('No catalog found');
              } else {
                var restaurant = snapshot.data?.restaurant;
                return Container(
                  child: Text(restaurant!.name),
                );
              }
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return const Text('data');
            }
          },
        ),
      ),
    );
  }
}
