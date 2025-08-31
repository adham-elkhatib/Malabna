import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Restaurants/restaurant_model.dart';

class RestaurantRepo extends FirestoreRepo<Restaurant> {
  RestaurantRepo()
      : super(
          'Restaurants',
        );

  @override
  Restaurant? toModel(Map<String, dynamic>? item) =>
      Restaurant.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Restaurant? item) => item?.toMap() ?? {};
}
