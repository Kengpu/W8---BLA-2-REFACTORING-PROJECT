import 'package:flutter/foundation.dart';
import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

sealed class RidePrefState {}

class RidePrefIdle extends RidePrefState {
  final List<RidePreference> history;
  final RidePreference? selected;
  RidePrefIdle({this.history = const [], this.selected});
}

class RidePrefLoading extends RidePrefState {}

class RidePrefError extends RidePrefState {
  final String message;
  RidePrefError(this.message);
}

class RidePreferenceNotifier extends ValueNotifier<RidePrefState> {
  final RidePreferenceRepository _repo;

  RidePreferenceNotifier(this._repo) : super(RidePrefIdle()) {
    _init();
  }

  RidePreference? get selected =>
      value is RidePrefIdle ? (value as RidePrefIdle).selected : null;

  List<RidePreference> get history =>
      value is RidePrefIdle ? (value as RidePrefIdle).history : [];

  Future<void> _init() async {
    value = RidePrefLoading();
    try {
      final history = await _repo.loadHistory();
      value = RidePrefIdle(history: history);
    } catch (e) {
      value = RidePrefError('Failed to load history: $e');
    }
  }

  Future<void> select(RidePreference pref) async {
    final current = value;
    if (current is! RidePrefIdle || current.selected == pref) return;

    value = RidePrefLoading();
    try {
      await _repo.addPreference(pref);
      final updated = await _repo.loadHistory();
      value = RidePrefIdle(history: updated, selected: pref);
    } catch (e) {
      value = RidePrefError('Failed to select preference: $e');
    }
  }
}