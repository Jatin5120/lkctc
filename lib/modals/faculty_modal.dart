import 'dart:convert';

import 'package:flutter/foundation.dart';

class FacultyModal {
  final String userID;
  final String facultyID;
  final String classID;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String department;
  final String designation;
  final bool isVerified;
  final List<String> classes;
  final List<String> subjects;

  const FacultyModal({
    required this.userID,
    required this.facultyID,
    required this.classID,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.department,
    required this.designation,
    required this.isVerified,
    required this.classes,
    required this.subjects,
  });

  FacultyModal copyWith({
    String? userID,
    String? facultyID,
    String? classID,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? department,
    String? designation,
    bool? isVerified,
    List<String>? classes,
    List<String>? subjects,
  }) {
    return FacultyModal(
      userID: userID ?? this.userID,
      facultyID: facultyID ?? this.facultyID,
      classID: classID ?? this.classID,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      isVerified: isVerified ?? this.isVerified,
      classes: classes ?? this.classes,
      subjects: subjects ?? this.subjects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'facultyID': facultyID,
      'classID': classID,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'department': department,
      'designation': designation,
      'isVerified': isVerified,
      'classes': classes,
      'subjects': subjects,
    };
  }

  factory FacultyModal.empty() {
    return const FacultyModal(
      userID: '',
      facultyID: '',
      classID: '',
      name: '',
      email: '',
      phone: '',
      password: '',
      department: '',
      designation: '',
      isVerified: false,
      classes: [],
      subjects: [],
    );
  }

  factory FacultyModal.fromMap(Map<String, dynamic> map) {
    return FacultyModal(
      userID: map['userID'] ?? '',
      facultyID: map['facultyID'] ?? '',
      classID: map['classID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      department: map['department'] ?? '',
      designation: map['designation'] ?? '',
      isVerified: map['isVerified'] ?? false,
      classes: List<String>.from(map['classes']),
      subjects: List<String>.from(map['subjects']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyModal.fromJson(String source) =>
      FacultyModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FacultyModal(userID: $userID, facultyID: $facultyID, classID: $classID, name: $name, email: $email, phone: $phone, password: $password, department: $department, designation: $designation, isVerified: $isVerified, classes: $classes, subjects: $subjects)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FacultyModal &&
        other.userID == userID &&
        other.facultyID == facultyID &&
        other.classID == classID &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.password == password &&
        other.department == department &&
        other.designation == designation &&
        other.isVerified == isVerified &&
        listEquals(other.classes, classes) &&
        listEquals(other.subjects, subjects);
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        facultyID.hashCode ^
        classID.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        department.hashCode ^
        designation.hashCode ^
        isVerified.hashCode ^
        classes.hashCode ^
        subjects.hashCode;
  }
}
