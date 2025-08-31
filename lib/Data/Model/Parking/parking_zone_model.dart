import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingZone {
  String id;
  String name;
  LatLng location;
  int totalSpots;
  int bookedSpots;

  ParkingZone({
    required this.id,
    required this.name,
    required this.location,
    required this.totalSpots,
    required this.bookedSpots,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': GeoPoint(location.latitude, location.longitude),
      // Convert LatLng back to GeoPoint
      'total_spots': totalSpots,
      'booked_spots': bookedSpots,
    };
  }

  factory ParkingZone.fromMap(Map<String, dynamic> map) {
    return ParkingZone(
      id: map['id'] as String,
      name: map['name'] as String,
      location: map['location'] is GeoPoint
          ? LatLng(map['location'].latitude, map['location'].longitude)
          : const LatLng(0, 0),
      totalSpots: map['total_spots'] as int,
      bookedSpots: map['booked_spots'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingZone.fromJson(String source) =>
      ParkingZone.fromMap(json.decode(source) as Map<String, dynamic>);
}
