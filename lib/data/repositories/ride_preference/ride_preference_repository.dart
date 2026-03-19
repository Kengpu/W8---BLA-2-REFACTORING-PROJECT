import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {

  Future<List<RidePreference>> loadHistory();

  Future<void> addPreference(RidePreference preference);

}