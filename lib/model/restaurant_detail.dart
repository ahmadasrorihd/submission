import 'dart:convert';

import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

RestaurantDetailResult restaurantDetailResultFromJson(String str) =>
    RestaurantDetailResult.fromJson(json.decode(str));

String restaurantDetailResultToJson(RestaurantDetailResult data) =>
    json.encode(data.toJson());

class RestaurantDetailResult {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: List<Category>.from(
          json["categories"].map((x) => Category.fromJson(x))),
      menus: Menus.fromJson(json["menus"]),
      rating: json["rating"]?.toDouble(),
      customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
