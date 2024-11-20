import 'package:flutter/material.dart';

class Period {
  final DateTime startDate;
  final DateTime endDate;
  final int cycleLength;
  final int periodLength;

  Period({
    required this.startDate,
    required this.endDate,
    this.cycleLength = 28,
    int? periodLength,
  }) : periodLength = periodLength ?? endDate.difference(startDate).inDays + 1;

  // Get next 3 predicted periods
  List<Period> getNextPredictedPeriods(int count) {
    List<Period> predictions = [];
    DateTime lastStart = startDate;

    for (int i = 0; i < count; i++) {
      DateTime nextStart = lastStart.add(Duration(days: cycleLength));
      DateTime nextEnd = nextStart.add(Duration(days: periodLength - 1));

      predictions.add(Period(
        startDate: nextStart,
        endDate: nextEnd,
        cycleLength: cycleLength,
        periodLength: periodLength,
      ));

      lastStart = nextStart;
    }
    return predictions;
  }

  // Calculate fertility windows for next 3 cycles
  List<DateTimeRange> getNextFertilityWindows(int count) {
    List<DateTimeRange> windows = [];
    DateTime lastStart = startDate;

    for (int i = 0; i < count; i++) {
      DateTime nextStart = lastStart.add(Duration(days: cycleLength));
      DateTime ovulation = nextStart.add(Duration(days: cycleLength - 14));

      windows.add(DateTimeRange(
        start: ovulation.subtract(const Duration(days: 5)),
        end: ovulation.add(const Duration(days: 1)),
      ));

      lastStart = nextStart;
    }
    return windows;
  }

  // Calculate ovulation day (typically 14 days before the next period)
  DateTime get ovulationDay {
    return startDate.add(Duration(days: cycleLength - 14));
  }

  // Calculate fertility window (typically 5 days before and 1 day after ovulation)
  DateTimeRange get fertilityWindow {
    final ovulation = ovulationDay;
    return DateTimeRange(
      start: ovulation.subtract(const Duration(days: 5)),
      end: ovulation.add(const Duration(days: 1)),
    );
  }

  // Calculate next period start date
  DateTime get nextPeriodStart {
    return startDate.add(Duration(days: cycleLength));
  }

  // Check if a given date falls within this period
  bool containsDate(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedStart =
        DateTime(startDate.year, startDate.month, startDate.day);
    final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day);

    return normalizedDate.isAtSameMomentAs(normalizedStart) ||
        normalizedDate.isAtSameMomentAs(normalizedEnd) ||
        (normalizedDate.isAfter(normalizedStart) &&
            normalizedDate.isBefore(normalizedEnd));
  }

  // Check if a given date is an ovulation day
  bool isOvulationDay(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedOvulation = DateTime(
      ovulationDay.year,
      ovulationDay.month,
      ovulationDay.day,
    );

    return normalizedDate.isAtSameMomentAs(normalizedOvulation);
  }

  // Check if a given date is within the fertility window
  bool isInFertilityWindow(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final window = fertilityWindow;
    final normalizedStart = DateTime(
      window.start.year,
      window.start.month,
      window.start.day,
    );
    final normalizedEnd = DateTime(
      window.end.year,
      window.end.month,
      window.end.day,
    );

    return normalizedDate.isAtSameMomentAs(normalizedStart) ||
        normalizedDate.isAtSameMomentAs(normalizedEnd) ||
        (normalizedDate.isAfter(normalizedStart) &&
            normalizedDate.isBefore(normalizedEnd));
  }

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'cycleLength': cycleLength,
      'periodLength': periodLength,
    };
  }

  // Create from Map for storage retrieval
  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      cycleLength: map['cycleLength'],
      periodLength: map['periodLength'],
    );
  }

  @override
  String toString() {
    return 'Period(startDate: $startDate, endDate: $endDate, cycleLength: $cycleLength, periodLength: $periodLength)';
  }
}
