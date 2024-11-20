

import 'package:todo_app2/Period_tracker/models/period.dart';

class PeriodData {
  final List<Period> periods;
  final int defaultCycleLength;

  PeriodData({
    List<Period>? periods,
    this.defaultCycleLength = 28,
  }) : periods = periods ?? [];

  // Add a new period
  void addPeriod(Period period) {
    periods.add(period);
    // Sort periods by start date
    periods.sort((a, b) => a.startDate.compareTo(b.startDate));
  }

  // Remove a period
  void removePeriod(Period period) {
    periods.remove(period);
  }

  // Get periods for a specific month
  List<Period> getPeriodsForMonth(DateTime month) {
    return periods.where((period) {
      final startYear = period.startDate.year;
      final startMonth = period.startDate.month;
      final endYear = period.endDate.year;
      final endMonth = period.endDate.month;

      return (startYear == month.year && startMonth == month.month) ||
          (endYear == month.year && endMonth == month.month) ||
          (period.startDate.isBefore(DateTime(month.year, month.month, 1)) &&
              period.endDate.isAfter(DateTime(month.year, month.month + 1, 0)));
    }).toList();
  }

  // Calculate average cycle length
  double get averageCycleLength {
    if (periods.length < 2) return defaultCycleLength.toDouble();

    var totalDays = 0;
    var count = 0;

    for (var i = 1; i < periods.length; i++) {
      totalDays +=
          periods[i].startDate.difference(periods[i - 1].startDate).inDays;
      count++;
    }

    return totalDays / count;
  }

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'periods': periods.map((period) => period.toMap()).toList(),
      'defaultCycleLength': defaultCycleLength,
    };
  }

  // Create from Map for storage retrieval
  factory PeriodData.fromMap(Map<String, dynamic> map) {
    return PeriodData(
      periods: (map['periods'] as List)
          .map((periodMap) => Period.fromMap(periodMap))
          .toList(),
      defaultCycleLength: map['defaultCycleLength'],
    );
  }
}
