import 'package:flutter/material.dart';
import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository repository;

  RidePreference? _selectedPreference;
  final List<RidePreference> _history = [];

  RidePreferenceState({required this.repository}) {
    _init();
  }

  RidePreference? get selectedPreference => _selectedPreference;
  List<RidePreference> get history => List.unmodifiable(_history);
  Future<void> _init() async {
    _history
      ..clear()
      ..addAll(await repository.loadHistory());
    notifyListeners();
  }

  Future<void> selectPreference(RidePreference preference) async {
    if (_selectedPreference == preference) return;

    _selectedPreference = preference;
    await repository.addPreference(preference);
    _history
      ..clear()
      ..addAll(await repository.loadHistory());

    notifyListeners();
  }
  void clearSelection() {
    _selectedPreference = null;
    notifyListeners();
  }
}