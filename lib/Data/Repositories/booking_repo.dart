import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/booking/booking.model.dart';

class BookingRepo extends FirestoreRepo<Booking> {
  BookingRepo()
      : super(
          'Bookings',
        );

  @override
  Booking? toModel(Map<String, dynamic>? item) => Booking.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Booking? item) => item?.toMap() ?? {};
}
