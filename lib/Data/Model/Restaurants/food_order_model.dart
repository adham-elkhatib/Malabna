import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_order_item_model.dart';
import 'food_order_status_enum.dart';

class FoodOrder {
  String id;
  String userId;
  List<FoodOrderItem> items;
  String restaurantId;
  DateTime date;
  FoodOrderStatus status;

  FoodOrder({
    required this.id,
    required this.userId,
    required this.items,
    required this.restaurantId,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      "restaurant_id": restaurantId,
      'items': items.map((item) => item.toMap()).toList(),
      'dateCreated': date,
      'order_status': status.index,
    };
  }

  factory FoodOrder.fromMap(Map<String, dynamic> map) {
    return FoodOrder(
      id: map['id'],
      userId: map['user_id'],
      restaurantId: map['restaurant_id'],
      date: (map['dateCreated'] as Timestamp).toDate(),
      items: (map['items'] as List<dynamic>)
          .map((itemMap) =>
              FoodOrderItem.fromMap(itemMap as Map<String, dynamic>))
          .toList(),
      status: FoodOrderStatus.values[map['order_status']],
    );
  }

  double calculateTotalPrice() {
    double subtotal = items.fold(
      0.0,
      (previousValue, item) =>
          previousValue + (item.item.price * item.quantity),
    );
    return subtotal;
  }
}
