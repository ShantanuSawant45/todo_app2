import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/period.dart';
import '../models/period_data.dart';

class PeriodProvider extends ChangeNotifier {
  PeriodData _periodData;
  final SharedPreferences _prefs;
  static const String _storageKey = 'period_data';

  PeriodProvider(this._prefs) : _periodData = PeriodData() {
    _loadData();
  }

  PeriodData get periodData => _periodData;
  List<Period> get periods => _periodData.periods;
  double get averageCycleLength => _periodData.averageCycleLength;

  Future<void> _loadData() async {
    final String? jsonStr = _prefs.getString(_storageKey);
    if (jsonStr != null) {
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      _periodData = PeriodData.fromMap(map);
      notifyListeners();
    }
  }

  Future<void> _saveData() async {
    final jsonStr = json.encode(_periodData.toMap());
    await _prefs.setString(_storageKey, jsonStr);
  }

  void addPeriod(Period period) {
    _periodData.addPeriod(period);
    _saveData();
    notifyListeners();
  }

  void removePeriod(Period period) {
    _periodData.removePeriod(period);
    _saveData();
    notifyListeners();
  }

  List<Period> getPeriodsForMonth(DateTime month) {
    return _periodData.getPeriodsForMonth(month);
  }
}
