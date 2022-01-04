import 'dart:convert';

class FacultyModal {
  final String userID;
  final String facultyID;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String department;
  final String designation;
  final bool isVerified;

  const FacultyModal({
    required this.userID,
    required this.facultyID,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.department,
    required this.designation,
    required this.isVerified,
  });

  FacultyModal copyWith({
    String? userID,
    String? facultyID,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? department,
    String? designation,
    bool? isVerified,
  }) {
    return FacultyModal(
      userID: userID ?? this.userID,
      facultyID: facultyID ?? this.facultyID,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'facultyID': facultyID,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'department': department,
      'designation': designation,
      'isVerified': isVerified,
    };
  }

  factory FacultyModal.empty() {
    return const FacultyModal(
      userID: '',
      facultyID: '',
      name: '',
      email: '',
      phone: '',
      password: '',
      department: '',
      designation: '',
      isVerified: false,
    );
  }

  factory FacultyModal.fromMap(Map<String, dynamic> map) {
    return FacultyModal(
      userID: map['userID'] ?? '',
      facultyID: map['facultyID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      department: map['department'] ?? '',
      designation: map['designation'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyModal.fromJson(String source) =>
      FacultyModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FacultyModal(userID: $userID, facultyID: $facultyID, name: $name, email: $email, phone: $phone, password: $password, department: $department, designation: $designation, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FacultyModal &&
        other.userID == userID &&
        other.facultyID == facultyID &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.password == password &&
        other.department == department &&
        other.designation == designation &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        facultyID.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        department.hashCode ^
        designation.hashCode ^
        isVerified.hashCode;
  }
}
