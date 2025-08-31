import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'parking_zone_model.dart';

class ParkingReservation {
  String id;
  DateTime validDate;
  String qrCode;
  ParkingZone parkingZone;

  ParkingReservation({
    required this.id,
    required this.validDate,
    required this.qrCode,
    required this.parkingZone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'valid_date': validDate,
      'qr_code': qrCode,
      "parking_zone": parkingZone.toMap(),
    };
  }

  factory ParkingReservation.fromMap(Map<String, dynamic> map) {
    return ParkingReservation(
      id: map['id'] as String,
      validDate: (map['valid_date'] as Timestamp).toDate(),
      qrCode: map['qr_code'],
      parkingZone: ParkingZone.fromMap(map["parking_zone"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingReservation.fromJson(String source) =>
      ParkingReservation.fromMap(json.decode(source) as Map<String, dynamic>);
}
