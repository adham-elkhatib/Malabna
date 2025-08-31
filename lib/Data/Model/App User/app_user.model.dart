import 'dart:convert';

class AppUser {
  String id;
  String email;
  String fName;
  String lName;
  String phoneNumber;

  AppUser({
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fName': fName,
      'lName': lName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'],
      fName: map['fName'],
      lName: map['lName'],
      phoneNumber: map['phone_number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
