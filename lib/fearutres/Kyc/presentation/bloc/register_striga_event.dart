import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';

abstract class StrigaEvent extends Equatable {
  const StrigaEvent();
}

class RegisterInStrigaEvent extends StrigaEvent {
  RegisterStrigaRequest request;
  RegisterInStrigaEvent({required this.request});

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}
