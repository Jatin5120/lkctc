import 'dart:convert';

import 'package:flutter/foundation.dart';

class AlumniModal {
  String alumniID;
  String name;
  String imageUrl;
  String email;
  String phoneNo;
  String job;
  List<String> expertise;

  AlumniModal({
    required this.alumniID,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.phoneNo,
    required this.job,
    required this.expertise,
  });

  AlumniModal copyWith({
    String? alumniID,
    String? name,
    String? imageUrl,
    String? email,
    String? phoneNo,
    String? job,
    List<String>? expertise,
  }) {
    return AlumniModal(
      alumniID: alumniID ?? this.alumniID,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      job: job ?? this.job,
      expertise: expertise ?? this.expertise,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alumniID': alumniID,
      'name': name,
      'imageUrl': imageUrl,
      'email': email,
      'phoneNo': phoneNo,
      'job': job,
      'expertise': expertise,
    };
  }

  factory AlumniModal.fromMap(Map<String, dynamic> map) {
    return AlumniModal(
      alumniID: map['alumniID'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      phoneNo: map['phoneNo'],
      job: map['job'],
      expertise: List<String>.from(map['expertise']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlumniModal.fromJson(String source) =>
      AlumniModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlumniModal(alumniID: $alumniID, name: $name, imageUrl: $imageUrl, email: $email, phoneNo: $phoneNo, job: $job, expertise: $expertise)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlumniModal &&
        other.alumniID == alumniID &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.email == email &&
        other.phoneNo == phoneNo &&
        other.job == job &&
        listEquals(other.expertise, expertise);
  }

  @override
  int get hashCode {
    return alumniID.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        email.hashCode ^
        phoneNo.hashCode ^
        job.hashCode ^
        expertise.hashCode;
  }
}
