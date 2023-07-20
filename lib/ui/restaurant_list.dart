import 'package:flutter/material.dart';
import 'package:restaurant_api/model/restaurant.dart';
import 'package:restaurant_api/ui/restaurant_detail.dart';
import 'package:restaurant_api/ui/search.dart';
import 'package:restaurant_api/util/constant.dart';

import '../core/api_client.dart';

class RestaurantList extends StatefulWidget {
  static String routeName = "/list";
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final ApiClient _apiClient = ApiClient();
  Future<RestaurantResult> getAllRestaurant() async {
    RestaurantResult userRes = await _apiClient.getAllRestaurant();
    return userRes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showSearch(context: context, delegate: Search());
                },
                child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35)),
                    child: const Row(
                      children: [
                        SizedBox(width: 12),
                        Icon(Icons.search),
                        SizedBox(width: 12),
                        Text('Search Restaurant'),
                      ],
                    )),
              ),
            ),
            FutureBuilder<RestaurantResult>(
              future: getAllRestaurant(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  if (snapshot.data!.restaurants.isEmpty) {
                    return const Text('No catalog found');
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data!.restaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          var restaurant = snapshot.data?.restaurants[index];
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RestaurantDetail.routeName,
                                  arguments: restaurant.id);
                            },
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            leading: Image.network(
                              '$baseUrl/images/small/${restaurant!.pictureId}',
                              width: 120,
                              errorBuilder: (ctx, error, _) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                            title: Text(restaurant.name.toString()),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.pin_drop),
                                    Text(restaurant.city.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(restaurant.rating.toString()),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Text('data');
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
