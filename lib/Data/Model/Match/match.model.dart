import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Parking/parking_zone_model.dart';
import '../seat_classification/seat_classification_model.dart';

class Match {
  final String id;
  final String matchDescription;
  final String imageUrl;
  final DateTime dateTime;
  final String firstTeam;
  final String secondTeam;
  List<SeatClassification> seatClassifications;
  List<ParkingZone> parking;

  Match({
    required this.id,
    required this.matchDescription,
    required this.imageUrl,
    required this.dateTime,
    required this.firstTeam,
    required this.secondTeam,
    required this.seatClassifications,
    required this.parking,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'match_description': matchDescription,
      'img_url': imageUrl,
      'date_time': dateTime,
      'first_team': firstTeam,
      'second_team': secondTeam,
      'seat_classifications': seatClassifications
          .map((classification) => classification.toMap())
          .toList(),
      'parking': parking.map((parking) => parking.toMap()).toList(),
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'] as String,
      matchDescription: map['match_description'],
      imageUrl: map['img_url'],
      dateTime: (map['date_time'] as Timestamp).toDate(),
      firstTeam: map['first_team'] as String,
      secondTeam: map['second_team'] as String,
      seatClassifications: (map['seat_classifications'] as List<dynamic>)
          .map((classificationMap) =>
              SeatClassification.fromMap(classificationMap))
          .toList(),
      parking: (map['parking'] as List<dynamic>)
          .map((parking) => ParkingZone.fromMap(parking))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);
}
