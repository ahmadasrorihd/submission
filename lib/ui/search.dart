import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/ui/restaurant_detail.dart';

import '../providers/provider.dart';
import '../util/constant.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.search(query);

    return Consumer<DataProvider>(builder: (context, data, child) {
      if (data.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (data.errorMessage.isNotEmpty) {
        return const Center(
          child: Text('No Internet Connection'),
        );
      } else {
        return data.searchResult.founded == 0
            ? const Center(child: Text('No data found'))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                itemCount: data.searchResult.restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  var restaurant = data.searchResult.restaurants[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RestaurantDetail.routeName,
                          arguments: restaurant.id);
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
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
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Column();
  }
}
