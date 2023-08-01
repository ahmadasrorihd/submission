import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_api/model/restaurant.dart';

void main() {
  late Map<String, dynamic> sampleJson;

  setUp(() {
    sampleJson = {
      "id": "1",
      "name": "Cafe Test",
      "description": "Desc Test",
      "pictureId": "1",
      "city": "cikeas",
      "rating": 4.5,
    };
  });

  test('should success while parsing json', () {
    final restaurant = Restaurant.fromJson(sampleJson);
    expect(restaurant.id, "1");
    expect(restaurant.name, "Cafe Test");
    expect(restaurant.description, "Desc Test");
    expect(restaurant.pictureId, "1");
    expect(restaurant.city, "cikeas");
    expect(restaurant.rating, 4.5);
  });
}
