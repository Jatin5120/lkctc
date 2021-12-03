import 'dart:convert';

class PendingModal {
  String userID;
  String pendingID;
  String name;
  String email;
  String phone;
  String designation;
  String department;

  PendingModal({
    required this.userID,
    required this.pendingID,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
    required this.department,
  });

  PendingModal copyWith({
    String? userID,
    String? pendingID,
    String? name,
    String? email,
    String? phone,
    String? designation,
    String? department,
  }) {
    return PendingModal(
      userID: userID ?? this.userID,
      pendingID: pendingID ?? this.pendingID,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      designation: designation ?? this.designation,
      department: department ?? this.department,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'pendingID': pendingID,
      'name': name,
      'email': email,
      'phone': phone,
      'designation': designation,
      'department': department,
    };
  }

  factory PendingModal.fromMap(Map<String, dynamic> map) {
    return PendingModal(
      userID: map['userID'],
      pendingID: map['pendingID'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      designation: map['designation'],
      department: map['department'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingModal.fromJson(String source) =>
      PendingModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PendingModal(userID: $userID, pendingID: $pendingID, name: $name, email: $email, phone: $phone, designation: $designation, department: $department)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PendingModal &&
        other.userID == userID &&
        other.pendingID == pendingID &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.designation == designation &&
        other.department == department;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        pendingID.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        designation.hashCode ^
        department.hashCode;
  }
}
