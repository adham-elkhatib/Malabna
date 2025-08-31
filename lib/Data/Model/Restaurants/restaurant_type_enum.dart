enum RestaurantType {
  all,
  coffee,
  pizza,
}

extension RestaurantTypeExtension on RestaurantType {
  String get displayName {
    switch (this) {
      case RestaurantType.all:
        return 'الكل';
      case RestaurantType.coffee:
        return 'قهوة';
      case RestaurantType.pizza:
        return 'بيتزا';
    }
  }
}
