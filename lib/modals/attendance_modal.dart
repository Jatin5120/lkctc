import 'dart:convert';

class AttendanceModal {
  final String attendanceID;
  final String classID;
  final String title;
  final String url;

  const AttendanceModal({
    required this.attendanceID,
    required this.classID,
    required this.title,
    required this.url,
  });

  AttendanceModal copyWith({
    String? attendanceID,
    String? classID,
    String? title,
    String? url,
  }) {
    return AttendanceModal(
      attendanceID: attendanceID ?? this.attendanceID,
      classID: classID ?? this.classID,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attendanceID': attendanceID,
      'classID': classID,
      'title': title,
      'url': url,
    };
  }

  factory AttendanceModal.fromMap(Map<String, dynamic> map) {
    return AttendanceModal(
      attendanceID: map['attendanceID'],
      classID: map['classID'],
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModal.fromJson(String source) =>
      AttendanceModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AttendanceModal(attendanceID: $attendanceID, classID: $classID, title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendanceModal &&
        other.attendanceID == attendanceID &&
        other.classID == classID &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode {
    return attendanceID.hashCode ^
        classID.hashCode ^
        title.hashCode ^
        url.hashCode;
  }
}
