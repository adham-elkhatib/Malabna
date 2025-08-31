import 'dart:convert';

import '../seat/seat.model.dart';

class SeatClassification {
  String id;
  String name;
  double price;
  String description;
  String imageUrl;
  List<Seat> seats;
  List<String> parkingZoneIds;
  List<String> sections;

  SeatClassification({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.seats,
    required this.parkingZoneIds,
    required this.sections,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      "image_url": imageUrl,
      "description": description,
      "parking_zone_ids": parkingZoneIds,
      'seats': seats.map((seat) => seat.toMap()).toList(),
      "sections": sections,
    };
  }

  factory SeatClassification.fromMap(Map<String, dynamic> map) {
    List<String> parkingZoneIds =
        List<String>.from(map['parking_zone_ids'] ?? []);
    List<String> sections = List<String>.from(map['sections'] ?? []);

    return SeatClassification(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map["description"] as String,
      price: (map['price'] as num).toDouble(),
      parkingZoneIds: parkingZoneIds,
      imageUrl: map["image_url"] as String,
      sections: sections,
      seats: (map['seats'] as List<dynamic>)
          .map((seatMap) => Seat.fromMap(seatMap as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SeatClassification.fromJson(String source) =>
      SeatClassification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant SeatClassification other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
