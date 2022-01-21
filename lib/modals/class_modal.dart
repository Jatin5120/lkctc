import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClassModal {
  final String classID;
  final String classInchargeID;
  final String department;
  final String semester;
  final String name;
  final List<String> faculties;
  final List<String> subjects;
  final List<String> students;
  final List<String> classRepresentatives;
  final List<String> attendanceReferences;

  const ClassModal({
    required this.classID,
    required this.classInchargeID,
    required this.department,
    required this.semester,
    required this.name,
    required this.faculties,
    required this.subjects,
    required this.students,
    required this.classRepresentatives,
    required this.attendanceReferences,
  });

  ClassModal copyWith({
    String? classID,
    String? classInchargeID,
    String? department,
    String? semester,
    String? name,
    List<String>? faculties,
    List<String>? subjects,
    List<String>? students,
    List<String>? classRepresentatives,
    List<String>? attendanceReferences,
  }) {
    return ClassModal(
      classID: classID ?? this.classID,
      classInchargeID: classInchargeID ?? this.classInchargeID,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      name: name ?? this.name,
      faculties: faculties ?? this.faculties,
      subjects: subjects ?? this.subjects,
      students: students ?? this.students,
      classRepresentatives: classRepresentatives ?? this.classRepresentatives,
      attendanceReferences: attendanceReferences ?? this.attendanceReferences,
    );
  }

  factory ClassModal.empty() {
    return const ClassModal(
      classID: '',
      classInchargeID: '',
      department: '',
      semester: '',
      name: '',
      faculties: [],
      subjects: [],
      students: [],
      classRepresentatives: [],
      attendanceReferences: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classID': classID,
      'classInchargeID': classInchargeID,
      'department': department,
      'semester': semester,
      'name': name,
      'faculties': faculties,
      'subjects': subjects,
      'students': students,
      'classRepresentatives': classRepresentatives,
      'attendanceReferences': attendanceReferences,
    };
  }

  factory ClassModal.fromMap(Map<String, dynamic> map) {
    return ClassModal(
      classID: map['classID'] ?? '',
      classInchargeID: map['classInchargeID'] ?? '',
      department: map['department'] ?? '',
      semester: map['semester'] ?? '',
      name: map['name'] ?? '',
      faculties: List<String>.from(map['faculties']),
      subjects: List<String>.from(map['subjects']),
      students: List<String>.from(map['students']),
      classRepresentatives: List<String>.from(map['classRepresentatives']),
      attendanceReferences: List<String>.from(map['attendanceReferences']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModal.fromJson(String source) =>
      ClassModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassModal(classID: $classID, classInchargeID: $classInchargeID, department: $department, semester: $semester, name: $name, faculties: $faculties, subjects: $subjects, students: $students, classRepresentatives: $classRepresentatives, attendanceReferences: $attendanceReferences)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassModal &&
        other.classID == classID &&
        other.classInchargeID == classInchargeID &&
        other.department == department &&
        other.semester == semester &&
        other.name == name &&
        listEquals(other.faculties, faculties) &&
        listEquals(other.subjects, subjects) &&
        listEquals(other.students, students) &&
        listEquals(other.classRepresentatives, classRepresentatives) &&
        listEquals(other.attendanceReferences, attendanceReferences);
  }

  @override
  int get hashCode {
    return classID.hashCode ^
        classInchargeID.hashCode ^
        department.hashCode ^
        semester.hashCode ^
        name.hashCode ^
        faculties.hashCode ^
        subjects.hashCode ^
        students.hashCode ^
        classRepresentatives.hashCode ^
        attendanceReferences.hashCode;
  }
}
