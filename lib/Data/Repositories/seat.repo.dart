import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/seat/seat.model.dart';

class SeatsRepo extends FirestoreRepo<Seat> {
  SeatsRepo()
      : super(
          'Seats',
        );

  @override
  Seat? toModel(Map<String, dynamic>? item) => Seat.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Seat? item) => item?.toMap() ?? {};
}
