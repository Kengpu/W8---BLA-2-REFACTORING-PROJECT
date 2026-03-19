import '../../../data/dummy_data.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'ride_preference_repository.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {

  final List<RidePreference> _preferences = List.from(fakeRidePrefs);

  @override
  Future<List<RidePreference>> loadHistory() async {
    return Future.value(_preferences);
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    _preferences.add(preference);
  }

}