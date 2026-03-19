import 'package:flutter/material.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../states/ride_preference_state.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState ridePreferenceState;

  HomeViewModel({required this.ridePreferenceState}) {
    ridePreferenceState.addListener(notifyListeners);
  }

  RidePreference? get selectedPreference =>
      ridePreferenceState.selectedPreference;

  List<RidePreference> get history => ridePreferenceState.history;

  Future<void> selectPreference(RidePreference preference) async {
    await ridePreferenceState.selectPreference(preference);
  }

  @override
  void dispose() {
    ridePreferenceState.removeListener(notifyListeners);
    super.dispose();
  }
}