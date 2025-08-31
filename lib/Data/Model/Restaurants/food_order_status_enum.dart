enum FoodOrderStatus {
  pendingSend,
  pendingApproval,
  preparing,
  readyForPickup,
  pickedUp,
  rejected
}

extension FoodOrderStatusExtension on FoodOrderStatus {
  String get name {
    switch (this) {
      case FoodOrderStatus.pendingSend:
        return 'فى انتظار الأرسال';
      case FoodOrderStatus.pendingApproval:
        return 'فى انتظار التأكيد';
      case FoodOrderStatus.preparing:
        return 'قيد التحضير';
      case FoodOrderStatus.readyForPickup:
        return 'جاهز للأستلام';
      case FoodOrderStatus.pickedUp:
        return 'تم للأستلام';
      case FoodOrderStatus.rejected:
        return 'مرفوض';
    }
  }
}
