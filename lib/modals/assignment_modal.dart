import 'dart:convert';

class AssignmentModal {
  final String assignmentID;
  final String classID;
  final String subjectID;
  final String facultyID;
  final String title;
  final int lastDate;
  final String assignmentLink;
  final String submissionLink;

  const AssignmentModal({
    required this.assignmentID,
    required this.classID,
    required this.subjectID,
    required this.facultyID,
    required this.title,
    required this.lastDate,
    required this.assignmentLink,
    required this.submissionLink,
  });

  AssignmentModal copyWith({
    String? assignmentID,
    String? classID,
    String? subjectID,
    String? facultyID,
    String? title,
    int? lastDate,
    String? assignmentLink,
    String? submissionLink,
  }) {
    return AssignmentModal(
      assignmentID: assignmentID ?? this.assignmentID,
      classID: classID ?? this.classID,
      subjectID: subjectID ?? this.subjectID,
      facultyID: facultyID ?? this.facultyID,
      title: title ?? this.title,
      lastDate: lastDate ?? this.lastDate,
      assignmentLink: assignmentLink ?? this.assignmentLink,
      submissionLink: submissionLink ?? this.submissionLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assignmentID': assignmentID,
      'classID': classID,
      'subjectID': subjectID,
      'facultyID': facultyID,
      'title': title,
      'lastDate': lastDate,
      'assignmentLink': assignmentLink,
      'submissionLink': submissionLink,
    };
  }

  factory AssignmentModal.fromMap(Map<String, dynamic> map) {
    return AssignmentModal(
      assignmentID: map['assignmentID'],
      classID: map['classID'],
      subjectID: map['subjectID'],
      facultyID: map['facultyID'],
      title: map['title'],
      lastDate: map['lastDate'],
      assignmentLink: map['assignmentLink'],
      submissionLink: map['submissionLink'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentModal.fromJson(String source) =>
      AssignmentModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssignmentModal(assignmentID: $assignmentID, classID: $classID, subjectID: $subjectID, facultyID: $facultyID, title: $title, lastDate: $lastDate, assignmentLink: $assignmentLink, submissionLink: $submissionLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignmentModal &&
        other.assignmentID == assignmentID &&
        other.classID == classID &&
        other.subjectID == subjectID &&
        other.facultyID == facultyID &&
        other.title == title &&
        other.lastDate == lastDate &&
        other.assignmentLink == assignmentLink &&
        other.submissionLink == submissionLink;
  }

  @override
  int get hashCode {
    return assignmentID.hashCode ^
        classID.hashCode ^
        subjectID.hashCode ^
        facultyID.hashCode ^
        title.hashCode ^
        lastDate.hashCode ^
        assignmentLink.hashCode ^
        submissionLink.hashCode;
  }
}
