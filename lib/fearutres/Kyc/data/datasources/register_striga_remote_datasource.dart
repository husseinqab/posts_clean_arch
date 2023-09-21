import 'dart:convert';

import 'package:posts_clean_arch/fearutres/Kyc/data/models/register_striga_model.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/update_data_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/verify_identity_request.dart';
import 'package:posts_clean_arch/fearutres/passengers/data/models/passenger_model.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/httpHelper.dart';

abstract class RegisterStrigaDataSource {
  /// Throws a [ServerException] for all error codes
  Future<RegisterStrigaModel> registerInStriga(RegisterStrigaRequest request);
  Future<String> verifyEmailStriga(VerifyIdentityRequest request);
  Future<String> verifyPhoneStriga(VerifyIdentityRequest request);
  Future<String> updateData(UpdateDataRequest request);
}

class RegisterStrigaDataSourceImpl implements RegisterStrigaDataSource {
  final RestHelper client;

  RegisterStrigaDataSourceImpl({required this.client});

  @override
  Future<RegisterStrigaModel> registerInStriga(RegisterStrigaRequest request) async {
    try {
      var body = await client.post("https://sandbox.doublewallet.io/api/Users/Register", request.toJson());

      return registerStrigaModelFromJson(jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> verifyEmailStriga(VerifyIdentityRequest request) async {
    try {
      var body = await client.post("https://sandbox.doublewallet.io/api/Users/VerifyEmail", request.toJson());

      return "Done successfully";
      //return jsonDecode(jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> verifyPhoneStriga(VerifyIdentityRequest request) async {
    try {
      var body = await client.post("https://sandbox.doublewallet.io/api/Users/VerifyPhone", request.toJson());

      return "Done successfully";
      //return jsonDecode(jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateData(UpdateDataRequest request) async {
    try {
      var body = await client.patch("https://sandbox.doublewallet.io/api/Users/UpdateUser", request.toJson());

      return "Done successfully";
      //return jsonDecode(jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }
}
