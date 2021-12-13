import 'dart:convert';

class StudentModal {
  final String studentID;
  final String name;
  final String roll;
  final String course;
  final String department;
  final String semester;

  const StudentModal({
    required this.studentID,
    required this.name,
    required this.roll,
    required this.course,
    required this.department,
    required this.semester,
  });

  StudentModal copyWith({
    String? studentID,
    String? name,
    String? roll,
    String? course,
    String? department,
    String? semester,
  }) {
    return StudentModal(
      studentID: studentID ?? this.studentID,
      name: name ?? this.name,
      roll: roll ?? this.roll,
      course: course ?? this.course,
      department: department ?? this.department,
      semester: semester ?? this.semester,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentID': studentID,
      'name': name,
      'roll': roll,
      'course': course,
      'department': department,
      'semester': semester,
    };
  }

  factory StudentModal.fromMap(Map<String, dynamic> map) {
    return StudentModal(
      studentID: map['studentID'],
      name: map['name'],
      roll: map['roll'],
      course: map['course'],
      department: map['department'],
      semester: map['semester'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModal.fromJson(String source) =>
      StudentModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentModal(studentID: $studentID, name: $name, roll: $roll, course: $course, department: $department, semester: $semester)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentModal &&
        other.studentID == studentID &&
        other.name == name &&
        other.roll == roll &&
        other.course == course &&
        other.department == department &&
        other.semester == semester;
  }

  @override
  int get hashCode {
    return studentID.hashCode ^
        name.hashCode ^
        roll.hashCode ^
        course.hashCode ^
        department.hashCode ^
        semester.hashCode;
  }
}
