import 'package:flutter/widgets.dart';
import 'package:restaurant_api/ui/restaurant_detail.dart';

import '../model/restaurant.dart';
import '../ui/home.dart';

final Map<String, WidgetBuilder> routes = {
  RestaurantDetail.routeName: (context) => RestaurantDetail(
        detailRestaurant:
            ModalRoute.of(context)?.settings.arguments as Restaurant,
      ),
  Home.routeName: (context) => const Home()
};
