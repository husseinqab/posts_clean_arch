

import 'package:flutter/material.dart';

class KycProvider extends ChangeNotifier {

  static var globalValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  };


  final registerFormKey = GlobalKey<FormState>();
  var firstName = '';

  String? Function(String?)? firstNameValidator = globalValidator;

  var lastName = '';
  String? Function(String?)? lastNameValidator = globalValidator;

  var email = '';
  String? Function(String?)? emailValidator = globalValidator;
  var phone = '';
  String? Function(String?)? phoneValidator = globalValidator;

  setFirstName(value){
    firstName = value;
    notifyListeners();
  }

  setLastName(value){
    lastName = value;
    notifyListeners();
  }

  setEmail(value){
    email = value;
    notifyListeners();
  }

  setPhone(value){
    phone = value;
    notifyListeners();
  }


  bool isValidRegister(){
    return firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && phone.isNotEmpty;
  }

  validateRegister(BuildContext context){
    if (registerFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered on striga')),
      );
    }
  }
  final emailVFormKey = GlobalKey<FormState>();
  String? Function(String?)? emailVCodeValidator = globalValidator;

  validateEmailVCode(BuildContext context){
    if (emailVFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email Verified')),
      );
    }
  }
  var emailVCode = '';
  bool isValidEmailCode(){
    return emailVCode.isNotEmpty;
  }

  setEmailVCode(value){
    emailVCode = value;
    notifyListeners();
  }
  final phoneVFormKey = GlobalKey<FormState>();
  String? Function(String?)? phoneVCodeValidator = globalValidator;

  validatePhoneVCode(BuildContext context){
    if (phoneVFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Verified')),
      );
    }
  }
  var phoneVCode = '';
  bool isValidPhoneCode(){
    return phoneVCode.isNotEmpty;
  }

  setPhoneVCode(value){
    phoneVCode = value;
    notifyListeners();
  }

  var addressLin1 = '';
  var city = '';
  var country = '';
  var postalCode = '';
  var nationality = '';
  var occupation = '';
  var sourceOfFunds = '';
  var purposeOfAccount = '';
  var placeOfBirth = '';
  var expectedOutgoingTxVolumeYearly = '';
  var expectedIncomingTxVolumeYearly = '';
}