import '../../../data/dummy_data.dart';
import '../../../model/ride/ride.dart';
import 'ride_repository.dart';

class RideRepositoryMock implements RideRepository {

  @override
  Future<List<Ride>> fetchRides() async {
    return Future.value(fakeRides);
  }

}