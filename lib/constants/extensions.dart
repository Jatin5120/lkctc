import 'package:intl/intl.dart';
import 'package:lkctc_student_app/constants/constants.dart';

extension Percentage on double {
  double get onePercent => (this * 0.01).roundToDouble();

  double get twoPercent => (this * 0.02).roundToDouble();

  double get twoPointFivePercent => (this * 0.025).roundToDouble();

  double get threePercent => (this * 0.03).roundToDouble();

  double get fivePercent => (this * 0.05).roundToDouble();

  double get sixPointFivePercent => (this * 0.065).roundToDouble();

  double get sevenPointFivePercent => (this * 0.075).roundToDouble();

  double get tenPercent => (this * 0.1).roundToDouble();

  double get twelvePercent => (this * 0.12).roundToDouble();

  double get fifteenPercent => (this * 0.15).roundToDouble();

  double get twentyPercent => (this * 0.2).roundToDouble();

  double get twentyFivePercent => (this * 0.25).roundToDouble();

  double get thirtyPercent => (this * 0.3).roundToDouble();

  double get thirtyFivePercent => (this * 0.35).roundToDouble();

  double get fortyPercent => (this * 0.4).roundToDouble();

  double get fiftyPercent => (this * 0.5).roundToDouble();

  double get seventyPercent => (this * 0.7).roundToDouble();

  double get eightyPercent => (this * 0.8).roundToDouble();

  double get eightyFivePercent => (this * 0.85).roundToDouble();

  double get ninetyPercent => (this * 0.9).roundToDouble();

  double get ninetyFivePercent => (this * 0.95).roundToDouble();
}

extension Type on String {
  UserType get type {
    switch (this) {
      case 'admin':
        return UserType.admin;
      case 'faculty':
        return UserType.faculty;
      case 'student':
        return UserType.student;
      default:
        return UserType.student;
    }
  }
}

extension TypeString on UserType {
  String get type {
    switch (this) {
      case UserType.admin:
        return 'admin';
      case UserType.faculty:
        return 'faculty';
      case UserType.student:
        return 'student';
    }
  }
}

extension FileName on DateTime {
  String get fileName => toString()
      .split('.')
      .first
      .replaceAll('-', '')
      .replaceAll(':', '')
      .replaceAll(' ', '_');
}

extension DateTimeParser on DateTime {
  String displayDateMonth() {
    return DateFormat('MMM dd').format(this);
  }

  String displayDate() {
    return DateFormat('dd').format(this);
  }
}
