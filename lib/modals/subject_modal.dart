import 'dart:convert';

class SubjectModal {
  final String subjectID;
  final String classID;
  final String facultyID;
  final String name;
  final String subjectCode;
  final String department;
  final int colorIndex;

  const SubjectModal({
    required this.subjectID,
    required this.classID,
    required this.facultyID,
    required this.name,
    required this.subjectCode,
    required this.department,
    required this.colorIndex,
  });

  SubjectModal copyWith({
    String? subjectID,
    String? classID,
    String? facultyID,
    String? name,
    String? subjectCode,
    String? department,
    int? colorIndex,
  }) {
    return SubjectModal(
      subjectID: subjectID ?? this.subjectID,
      classID: classID ?? this.classID,
      facultyID: facultyID ?? this.facultyID,
      name: name ?? this.name,
      subjectCode: subjectCode ?? this.subjectCode,
      department: department ?? this.department,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectID': subjectID,
      'classID': classID,
      'facultyID': facultyID,
      'name': name,
      'subjectCode': subjectCode,
      'department': department,
      'colorIndex': colorIndex,
    };
  }

  factory SubjectModal.fromMap(Map<String, dynamic> map) {
    return SubjectModal(
      subjectID: map['subjectID'],
      classID: map['classID'],
      facultyID: map['facultyID'],
      name: map['name'],
      subjectCode: map['subjectCode'],
      department: map['department'],
      colorIndex: map['colorIndex'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModal.fromJson(String source) =>
      SubjectModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubjectModal(subjectID: $subjectID, classID: $classID, facultyID: $facultyID, name: $name, subjectCode: $subjectCode, department: $department, colorIndex: $colorIndex)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectModal &&
        other.subjectID == subjectID &&
        other.classID == classID &&
        other.facultyID == facultyID &&
        other.name == name &&
        other.subjectCode == subjectCode &&
        other.department == department &&
        other.colorIndex == colorIndex;
  }

  @override
  int get hashCode {
    return subjectID.hashCode ^
        classID.hashCode ^
        facultyID.hashCode ^
        name.hashCode ^
        subjectCode.hashCode ^
        department.hashCode ^
        colorIndex.hashCode;
  }
}
