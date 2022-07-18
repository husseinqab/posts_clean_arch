import 'errors/failure.dart';

class Helpers {
  static mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is NoInternetFailure){
      return 'No Internet';
    }
    return 'Unexpected Error';
  }
}