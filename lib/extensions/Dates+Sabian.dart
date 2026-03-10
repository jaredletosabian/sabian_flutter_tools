import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SabianDateExtension on DateTime {
  String toFormattedString(String pattern) {
    DateFormat format = DateFormat(pattern);
    return format.format(this);
  }

  DateTime toJustDate() {
    return DateUtils.dateOnly(this);
  }
}
extension SabianStringDate on String {
  DateTime toDate([String? pattern]) {
    if (pattern == null) {
      return DateTime.parse(this);
    }
    DateFormat format = DateFormat(pattern);
    return format.parse(this);
  }

  DateTime? toDateOrNull([String? pattern]) {
    try {
      return toDate(pattern);
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeComparison on DateTime {
  bool isSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension SabianIntDateExtension on int {
  /// Converts milliseconds (or seconds if multiplied) to HH:mm:ss
  /// Logic equivalent to Long.toHoursMinutesSeconds()
  String toHoursMinutesSeconds() {
    // Assuming 'this' is seconds based on the Kotlin code (this * 1000)
    Duration duration = Duration(seconds: this);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    // duration.inHours handles values > 24 if necessary
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension SabianStringDateConversion on String {
  /// Converts a value like "00:00:00.00000" to DateTime
  /// Logic equivalent to String.hourMinuteSecondsToDateTime()
  DateTime? hourMinuteSecondsToDateTime({DateTime? useDate}) {
    try {
      final dateToUse = useDate ?? DateTime.now();

      // Split by "." to remove fractional seconds/offsets and take the HH:mm:ss part
      final strictHourMinutes = this.split(".").first;

      // Format: yyyy-MM-dd
      final datePart = DateFormat('yyyy-MM-dd').format(dateToUse);

      // Dart's DateTime.parse expects ISO 8601: "2023-01-01T12:00:00"
      return DateTime.parse("${datePart}T$strictHourMinutes");
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
