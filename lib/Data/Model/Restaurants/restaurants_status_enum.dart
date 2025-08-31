import 'package:flutter/material.dart';

enum RestaurantsStatus {
  open,
  busy,
  closed,
}

extension StatusExtension on RestaurantsStatus {
  String get name {
    switch (this) {
      case RestaurantsStatus.open:
        return 'مفتوح';
      case RestaurantsStatus.busy:
        return 'مشغول';
      case RestaurantsStatus.closed:
        return 'مغلق';
    }
  }

  Color get color {
    switch (this) {
      case RestaurantsStatus.open:
        return Colors.green.withOpacity(0.85); // Green for open
      case RestaurantsStatus.busy:
        return Colors.orange.withOpacity(0.85); // Orange for busy
      case RestaurantsStatus.closed:
        return Colors.red.withOpacity(0.85); // Red for closed
    }
  }
}
