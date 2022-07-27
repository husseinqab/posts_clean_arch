import 'errors/failure.dart';

class Helpers {
  static mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is NoInternetFailure){
      return 'No Internet';
    } else if (failure is UnAurhtorizedFailure){
      return 'UnAuthorized';
    } else if (failure is NotFoundFailure){
      return 'Not found';
    }
    return 'Unexpected Error';
  }
}