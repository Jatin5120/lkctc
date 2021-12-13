import 'dart:convert';

class EventModal {
  final String evendID;
  final String name;
  final String description;
  final int lastDate;
  final String registerationLink;
  final String submissionLink;

  const EventModal({
    required this.evendID,
    required this.name,
    required this.description,
    required this.lastDate,
    required this.registerationLink,
    required this.submissionLink,
  });

  EventModal copyWith({
    String? evendID,
    String? name,
    String? description,
    int? lastDate,
    String? registerationLink,
    String? submissionLink,
  }) {
    return EventModal(
      evendID: evendID ?? this.evendID,
      name: name ?? this.name,
      description: description ?? this.description,
      lastDate: lastDate ?? this.lastDate,
      registerationLink: registerationLink ?? this.registerationLink,
      submissionLink: submissionLink ?? this.submissionLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'evendID': evendID,
      'name': name,
      'description': description,
      'lastDate': lastDate,
      'registerationLink': registerationLink,
      'submissionLink': submissionLink,
    };
  }

  factory EventModal.fromMap(Map<String, dynamic> map) {
    return EventModal(
      evendID: map['evendID'],
      name: map['name'],
      description: map['description'],
      lastDate: map['lastDate'],
      registerationLink: map['registerationLink'],
      submissionLink: map['submissionLink'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModal.fromJson(String source) =>
      EventModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModal(evendID: $evendID, name: $name, description: $description, lastDate: $lastDate, registerationLink: $registerationLink, submissionLink: $submissionLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModal &&
        other.evendID == evendID &&
        other.name == name &&
        other.description == description &&
        other.lastDate == lastDate &&
        other.registerationLink == registerationLink &&
        other.submissionLink == submissionLink;
  }

  @override
  int get hashCode {
    return evendID.hashCode ^
        name.hashCode ^
        description.hashCode ^
        lastDate.hashCode ^
        registerationLink.hashCode ^
        submissionLink.hashCode;
  }
}
