import 'package:flutter/widgets.dart';
import 'package:restaurant_api/ui/restaurant_detail.dart';
import 'package:restaurant_api/ui/restaurant_list.dart';

final Map<String, WidgetBuilder> routes = {
  RestaurantDetail.routeName: (context) => RestaurantDetail(
        restaurantId: ModalRoute.of(context)?.settings.arguments as String,
      ),
  RestaurantList.routeName: (context) => const RestaurantList()
};
