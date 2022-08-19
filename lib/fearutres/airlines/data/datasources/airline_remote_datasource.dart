import 'package:posts_clean_arch/core/errors/exception.dart';
import 'package:posts_clean_arch/core/httpHelper.dart';
import 'package:posts_clean_arch/fearutres/airlines/data/models/airline_model.dart';

abstract class AirlineRemoteDataSource {
  Future<List<AirlineModel>> getAllAirlines();
}

class AirlineRemoteDataSourceImpl extends AirlineRemoteDataSource {
  final RestHelper client;

  AirlineRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AirlineModel>> getAllAirlines() async {
    try {
      var body = await client.get('https://api.instantwebtools.net/v1/airlines?page=0&size=10');

      return airlineFromJson(body);
    } catch(e){
      throw UnExpectedException();
    }
  }
}