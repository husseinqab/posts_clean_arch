import 'package:posts_clean_arch/fearutres/passengers/data/models/passenger_model.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/httpHelper.dart';

abstract class PassengersRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/posts endpoint
  /// Throws a [ServerException] for all error codes
  Future<PassengerResponseModel> getPassengers(int page);
}

class PassengersRemoteDataSourceImpl implements PassengersRemoteDataSource {
  final RestHelper client;

  PassengersRemoteDataSourceImpl({required this.client});

  @override
  Future<PassengerResponseModel> getPassengers(int page) async {
    try {
      var body = await client.get(
          'https://api.instantwebtools.net/v1/passenger?page=$page&size=10');

      return passengerFromJson(body);
    } catch (_) {
      throw UnExpectedException();
    }
  }
}
