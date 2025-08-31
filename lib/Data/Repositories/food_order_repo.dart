import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Restaurants/food_order_model.dart';

class FoodOrderRepo extends FirestoreRepo<FoodOrder> {
  FoodOrderRepo()
      : super(
          'Food Orders',
        );

  @override
  FoodOrder? toModel(Map<String, dynamic>? item) =>
      FoodOrder.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(FoodOrder? item) => item?.toMap() ?? {};
}
