import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class RestaurantList extends StatefulWidget {
  static String routeName = "/list";
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  void initState() {
    super.initState();

    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer<DataProvider>(
        // Consumer widget to listen for changes in UserViewModel
        builder: (context, data, child) {
          if (data.loading) {
            // If data is still loading, show a progress indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.errorMessage.isNotEmpty) {
            // If there is an error, show the error message
            return Center(
              child: Text(data.errorMessage),
            );
          } else {
            // Otherwise, show the list of users
            return ListView.builder(
              itemCount: data.listRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                final user = data.listRestaurant.restaurants[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.name),
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                );
              },
            );
          }
        },
      ),
    );

    // if (data.) {
    //   return Text(restaurantData.listRestaurant.message);
    // } else {
    //   return Scaffold(
    //     body: SafeArea(
    //         child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: InkWell(
    //               onTap: () {
    //                 showSearch(context: context, delegate: Search());
    //               },
    //               child: Container(
    //                   height: 48,
    //                   decoration: BoxDecoration(
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Colors.grey.withOpacity(0.5),
    //                           spreadRadius: 5,
    //                           blurRadius: 7,
    //                           offset: const Offset(
    //                               0, 3), // changes position of shadow
    //                         ),
    //                       ],
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(35)),
    //                   child: const Row(
    //                     children: [
    //                       SizedBox(width: 12),
    //                       Icon(Icons.search),
    //                       SizedBox(width: 12),
    //                       Text('Search Restaurant'),
    //                     ],
    //                   )),
    //             ),
    //           ),
    //           restaurantData.loading
    //               ? const Center(
    //                   child: CircularProgressIndicator(),
    //                 )
    //               : ListView.builder(
    //                   scrollDirection: Axis.vertical,
    //                   shrinkWrap: true,
    //                   primary: false,
    //                   padding: const EdgeInsets.all(10),
    //                   itemCount:
    //                       restaurantData.listRestaurant.restaurants.length,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     var restaurant =
    //                         restaurantData.listRestaurant.restaurants[index];
    //                     return ListTile(
    //                       onTap: () {
    //                         Navigator.pushNamed(
    //                             context, RestaurantDetail.routeName,
    //                             arguments: restaurant.id);
    //                       },
    //                       contentPadding: const EdgeInsets.symmetric(
    //                           horizontal: 16.0, vertical: 8.0),
    //                       leading: Image.network(
    //                         '$baseUrl/images/small/${restaurant.pictureId}',
    //                         width: 120,
    //                         errorBuilder: (ctx, error, _) =>
    //                             const Center(child: Icon(Icons.error)),
    //                       ),
    //                       title: Text(restaurant.name.toString()),
    //                       subtitle: Column(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               const Icon(Icons.pin_drop),
    //                               Text(restaurant.city.toString()),
    //                             ],
    //                           ),
    //                           Row(
    //                             children: [
    //                               const Icon(
    //                                 Icons.star,
    //                                 color: Colors.yellow,
    //                               ),
    //                               Text(restaurant.rating.toString()),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     );
    //                   })
    //         ],
    //       ),
    //     )),
    //   );
    // }
  }
}
