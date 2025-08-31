import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Parking/parking_reservation.dart';
import '../seat/seat.model.dart';

class Booking {
  String id;
  String userId;
  DateTime bookingTime;
  double totalPrice;
  String paymentStatus;
  String qrCode;
  ParkingReservation? parkingReservation;
  List<Seat> bookedSeats;
  String matchId;
  String ticketCategory;

  Booking({
    required this.id,
    required this.userId,
    required this.bookingTime,
    required this.totalPrice,
    required this.paymentStatus,
    required this.qrCode,
    this.parkingReservation,
    required this.matchId,
    required this.bookedSeats,
    required this.ticketCategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      "user_id": userId,
      'dateCreated': bookingTime,
      'total_price': totalPrice,
      'payment_status': paymentStatus,
      'qr_code': qrCode,
      "parking_reservation": parkingReservation?.toMap(),
      "match_id": matchId,
      'booked_seats': bookedSeats.map((seat) => seat.toMap()).toList(),
      "ticket_category": ticketCategory,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      userId: map["user_id"] as String,
      bookingTime: (map['dateCreated'] as Timestamp).toDate(),
      totalPrice: map['total_price'],
      paymentStatus: map['payment_status'],
      qrCode: map['qr_code'],
      parkingReservation: map["parking_reservation"] != null
          ? ParkingReservation.fromMap(
              map["parking_reservation"] as Map<String, dynamic>,
            )
          : null,
      bookedSeats: (map['booked_seats'] as List<dynamic>)
          .map((seatMap) => Seat.fromMap(seatMap as Map<String, dynamic>))
          .toList(),
      matchId: map["match_id"],
      ticketCategory: map["ticket_category"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
