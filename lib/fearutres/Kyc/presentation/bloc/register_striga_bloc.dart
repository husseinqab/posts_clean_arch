
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/usecases/register_striga_usecase.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/register_striga_event.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/register_striga_state.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/verify_identity_state.dart';

import '../../../../core/helper.dart';

class RegisterInStrigaBloc extends Bloc<StrigaEvent, RegisterStrigaState> {
  final RegisterInStriga registerInStriga;

  RegisterInStrigaBloc(this.registerInStriga) : super(RegisterStrigaInitial()) {
    on<RegisterInStrigaEvent>((event, emit) async {
      if (event is RegisterInStrigaEvent) {
        emit(RegisterStrigaLoading());
        final eitherFailureOrAirlinesList = await registerInStriga(event.request);

        eitherFailureOrAirlinesList.fold(
                (failure) => emit(
                RegisterStrigaFailed(message: Helpers.mapFailureToMessage(failure))),
                (registerResponse) => emit(RegisterStrigaLoaded(registerStrigaResponse: registerResponse)));
      }
    });

  }
}

class VerifyEmailBloc extends Bloc<VerifyEmailStrigaEvent, VerifyIdentityState> {
  final VerifyEmailStriga verifyEmailStriga;

  VerifyEmailBloc(this.verifyEmailStriga) : super(VerifyIdentityInitial()) {
    on<VerifyEmailStrigaEvent>((event, emit) async {
      if (event is VerifyEmailStrigaEvent) {
        emit(VerifyIdentityLoading());
        final eitherFailureOrAirlinesList = await verifyEmailStriga(event.request);

        eitherFailureOrAirlinesList.fold(
                (failure) => emit(
                VerifyIdentityFailed(message: Helpers.mapFailureToMessage(failure))),
                (verifyResponse) => emit(VerifyIdentityLoaded(verifyResponse: verifyResponse)));
      }
    });

  }
}
