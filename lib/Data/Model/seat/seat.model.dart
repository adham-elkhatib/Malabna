import 'dart:convert';

class Seat {
  String id;
  int number;
  bool isAvailable;

  Seat({
    required this.id,
    required this.number,
    required this.isAvailable,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'is_available': isAvailable,
    };
  }

  factory Seat.fromMap(Map<String, dynamic> map) {
    return Seat(
      id: map['id'] as String,
      number: map['number'],
      isAvailable: map['is_available'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Seat.fromJson(String source) =>
      Seat.fromMap(json.decode(source) as Map<String, dynamic>);
}
