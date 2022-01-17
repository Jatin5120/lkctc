import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lkctc_student_app/modals/modals.dart';

class ClassModal {
  final String classID;
  final String classInchargeID;
  final String department;
  final String semester;
  final String name;
  final List<SubjectModal> subjects;
  final List<StudentModal> students;
  final List<StudentModal> classRepresentatives;
  final List<String> attendanceReferences;

  const ClassModal({
    required this.classID,
    required this.classInchargeID,
    required this.department,
    required this.semester,
    required this.name,
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
    List<SubjectModal>? subjects,
    List<StudentModal>? students,
    List<StudentModal>? classRepresentatives,
    List<String>? attendanceReferences,
  }) {
    return ClassModal(
      classID: classID ?? this.classID,
      classInchargeID: classInchargeID ?? this.classInchargeID,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      name: name ?? this.name,
      subjects: subjects ?? this.subjects,
      students: students ?? this.students,
      classRepresentatives: classRepresentatives ?? this.classRepresentatives,
      attendanceReferences: attendanceReferences ?? this.attendanceReferences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classID': classID,
      'classInchargeID': classInchargeID,
      'department': department,
      'semester': semester,
      'name': name,
      'subjects': subjects.map((x) => x.toMap()).toList(),
      'students': students.map((x) => x.toMap()).toList(),
      'classRepresentatives':
          classRepresentatives.map((x) => x.toMap()).toList(),
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
      subjects: List<SubjectModal>.from(
          map['subjects']?.map((x) => SubjectModal.fromMap(x))),
      students: List<StudentModal>.from(
          map['students']?.map((x) => StudentModal.fromMap(x))),
      classRepresentatives: List<StudentModal>.from(
          map['classRepresentatives']?.map((x) => StudentModal.fromMap(x))),
      attendanceReferences: List<String>.from(map['attendanceReferences']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModal.fromJson(String source) =>
      ClassModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassModal(classID: $classID, classInchargeID: $classInchargeID, department: $department, semester: $semester, name: $name, subjects: $subjects, students: $students, classRepresentatives: $classRepresentatives, attendanceReferences: $attendanceReferences)';
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
        subjects.hashCode ^
        students.hashCode ^
        classRepresentatives.hashCode ^
        attendanceReferences.hashCode;
  }
}
