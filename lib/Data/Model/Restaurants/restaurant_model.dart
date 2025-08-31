import 'item_model.dart';
import 'restaurant_type_enum.dart';
import 'restaurants_status_enum.dart';

class Restaurant {
  String id;
  String restaurantNameAr;
  String restaurantNameEn;
  String logoUrl;
  RestaurantsStatus status;
  List<Item> items;
  RestaurantType restaurantType;

  Restaurant({
    required this.id,
    required this.restaurantNameAr,
    required this.restaurantNameEn,
    required this.items,
    required this.logoUrl,
    required this.restaurantType,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "logo_url": logoUrl,
      'restaurant_name_ar': restaurantNameAr,
      'restaurant_name_en': restaurantNameEn,
      'items': items.map((item) => item.toMap()).toList(),
      "restaurant_type": restaurantType.index,
      "availability_status": status.index,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      logoUrl: map['logo_url'],
      restaurantNameAr: map['restaurant_name_ar'] as String,
      restaurantNameEn: map['restaurant_name_en'] as String,
      restaurantType: RestaurantType.values[map['restaurant_type']],
      status: RestaurantsStatus.values[map['availability_status']],
      items: (map['items'] as List<dynamic>)
          .map((itemMap) => Item.fromMap(itemMap))
          .toList(),
    );
  }
}
