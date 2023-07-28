import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/ui/restaurant_detail.dart';

import '../providers/db_provider.dart';
import '../util/constant.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    final dataProvider = Provider.of<DbProvider>(context, listen: false);
    dataProvider.getAllFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<DbProvider>(
      builder: (context, data, child) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(10),
            itemCount: data.restaurant.length,
            itemBuilder: (BuildContext context, int index) {
              var restaurant = data.restaurant[index];
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RestaurantDetail.routeName,
                      arguments: restaurant);
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Image.network(
                  '$baseUrl/images/small/${restaurant.pictureId}',
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
      },
    ));
  }
}
