import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/util/constant.dart';

import '../providers/provider.dart';

class RestaurantDetail extends StatefulWidget {
  static String routeName = "/detail";
  final String restaurantId;

  const RestaurantDetail({super.key, required this.restaurantId});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getRestaurantDetail(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Restaurant'),
        ),
        body: SafeArea(
          child: Consumer<DataProvider>(builder: (context, data, child) {
            if (data.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.errorMessage.isNotEmpty) {
              return const Center(
                child: Text('No Internet Connection'),
              );
            } else {
              var restaurant = data.detailRestaurant.restaurant;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220.0,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '$baseUrl/images/small/${restaurant.pictureId}')),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(restaurant.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(Icons.pin_drop),
                            Text(restaurant.city),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      maxLines: 4,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Makanan",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: restaurant.menus.foods.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.deepOrange),
                            child: Center(
                              child: Text(
                                restaurant.menus.foods[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Minuman",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: restaurant.menus.drinks.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.deepOrange),
                            child: Center(
                              child: Text(
                                restaurant.menus.drinks[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
        ));
  }
}
