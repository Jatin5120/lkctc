import 'dart:convert';

class NoticeModal {
  String noticeID;
  String title;
  String description;
  String imageUrl;
  int date;

  NoticeModal({
    required this.noticeID,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });

  NoticeModal copyWith({
    String? noticeID,
    String? title,
    String? description,
    String? imageUrl,
    int? date,
  }) {
    return NoticeModal(
      noticeID: noticeID ?? this.noticeID,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noticeID': noticeID,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'date': date,
    };
  }

  factory NoticeModal.fromMap(Map<String, dynamic> map) {
    return NoticeModal(
      noticeID: map['noticeID'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NoticeModal.fromJson(String source) =>
      NoticeModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoticeModal(noticeID: $noticeID, title: $title, description: $description, imageUrl: $imageUrl, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoticeModal &&
        other.noticeID == noticeID &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.date == date;
  }

  @override
  int get hashCode {
    return noticeID.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        date.hashCode;
  }
}
