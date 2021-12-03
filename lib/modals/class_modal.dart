import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:lkctc_student_app/modals/modals.dart';

class ClassModal {
  String classID;
  String department;
  String semester;
  String name;
  List<SubjectModal> subjects;
  List<StudentModal> students;
  List<StudentModal> classRepresentatives;

  ClassModal({
    required this.classID,
    required this.department,
    required this.semester,
    required this.name,
    required this.subjects,
    required this.students,
    required this.classRepresentatives,
  });

  ClassModal copyWith({
    String? classID,
    String? department,
    String? semester,
    String? name,
    List<SubjectModal>? subjects,
    List<StudentModal>? students,
    List<StudentModal>? classRepresentatives,
  }) {
    return ClassModal(
      classID: classID ?? this.classID,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      name: name ?? this.name,
      subjects: subjects ?? this.subjects,
      students: students ?? this.students,
      classRepresentatives: classRepresentatives ?? this.classRepresentatives,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classID': classID,
      'department': department,
      'semester': semester,
      'name': name,
      'subjects': subjects.map((x) => x.toMap()).toList(),
      'students': students.map((x) => x.toMap()).toList(),
      'classRepresentatives':
          classRepresentatives.map((x) => x.toMap()).toList(),
    };
  }

  factory ClassModal.fromMap(Map<String, dynamic> map) {
    return ClassModal(
      classID: map['classID'],
      department: map['department'],
      semester: map['semester'],
      name: map['name'],
      subjects: List<SubjectModal>.from(
          map['subjects']?.map((x) => SubjectModal.fromMap(x))),
      students: List<StudentModal>.from(
          map['students']?.map((x) => StudentModal.fromMap(x))),
      classRepresentatives: List<StudentModal>.from(
          map['classRepresentatives']?.map((x) => StudentModal.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModal.fromJson(String source) =>
      ClassModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassModal(classID: $classID, department: $department, semester: $semester, name: $name, subjects: $subjects, students: $students, classRepresentatives: $classRepresentatives)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassModal &&
        other.classID == classID &&
        other.department == department &&
        other.semester == semester &&
        other.name == name &&
        listEquals(other.subjects, subjects) &&
        listEquals(other.students, students) &&
        listEquals(other.classRepresentatives, classRepresentatives);
  }

  @override
  int get hashCode {
    return classID.hashCode ^
        department.hashCode ^
        semester.hashCode ^
        name.hashCode ^
        subjects.hashCode ^
        students.hashCode ^
        classRepresentatives.hashCode;
  }
}
