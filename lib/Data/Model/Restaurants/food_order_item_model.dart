import 'item_model.dart';

class FoodOrderItem {
  String id;
  Item item;
  int quantity;

  FoodOrderItem({
    required this.id,
    required this.item,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': item.toMap(),
      'quantity': quantity,
    };
  }

  factory FoodOrderItem.fromMap(Map<String, dynamic> map) {
    return FoodOrderItem(
      id: map['id'],
      item: Item.fromMap(map['items']),
      quantity: map['quantity'],
    );
  }
}
