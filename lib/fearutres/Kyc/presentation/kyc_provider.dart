

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
  var documentIssueController = TextEditingController(text: '');

  var _documentIssuingCountry = '';

  get documentIssuingCountry => _documentIssuingCountry.isEmpty ? 'Document Issuing Country' : _documentIssuingCountry;

  set documentIssuingCountry(value) {
    documentIssueController.text = value.name + " " + value.flagEmoji;
    _documentIssuingCountry = value.countryCode;
    notifyListeners();
  }

  String? Function(String?)? documentIssueValidator = globalValidator;

  var nationalityController = TextEditingController(text: '');

  var _nationality = '';

  get nationality => _nationality.isEmpty ?  'Nationality' : _nationality;

  set nationality(value) {
    nationalityController.text = value.name + " " + value.flagEmoji;
    _nationality = value.countryCode;
    notifyListeners();
  }

  String? Function(String?)? nationalityValidator = globalValidator;

  var _occupation = '';


  get occupation => _occupation.isEmpty ? 'Occupation' : _occupation;

  String? Function(String?)? occupationValidator = globalValidator;


  set occupation(value) {
    _occupation = value;
    notifyListeners();
  }
  var _sourceOfFunds = '';

  get sourceOfFunds => _sourceOfFunds.isEmpty ? 'Source of funds' : _sourceOfFunds;

  String? Function(String?)? sourceOfFundsValidator = globalValidator;


  set sourceOfFunds(value) {
    _sourceOfFunds = value;
    notifyListeners();
  }
  var _purposeOfAccount = '';

  get purposeOfAccount => _purposeOfAccount.isEmpty ? 'Purpose of Account' : _purposeOfAccount;

  set purposeOfAccount(value) {
    _purposeOfAccount = value;
    notifyListeners();
  }
  var _placeOfBirth = '';

  get placeOfBirth => _placeOfBirth.isEmpty ? 'Place of Birth' : _placeOfBirth;
  var placeOfBirthController = TextEditingController(text: '');


  set placeOfBirth(value) {
    placeOfBirthController.text = value.name + " " + value.flagEmoji;
    _placeOfBirth = value.countryCode;
    notifyListeners();
  }

  String? Function(String?)? placeOfBirthValidator = globalValidator;

  var _expectedOutgoingTxVolumeYearly = '';

  get expectedOutgoingTxVolumeYearly => _expectedOutgoingTxVolumeYearly.isEmpty ? 'Annually outgoing transactions volume' : _expectedOutgoingTxVolumeYearly;

  set expectedOutgoingTxVolumeYearly(value) {
    _expectedOutgoingTxVolumeYearly = value;
    notifyListeners();
  }

  String? Function(String?)? expectedOutgoingValidator = globalValidator;

  var _expectedIncomingTxVolumeYearly = '';

  get expectedIncomingTxVolumeYearly => _expectedIncomingTxVolumeYearly.isEmpty ? 'Annually outgoing transactions volume' : _expectedIncomingTxVolumeYearly;

  set expectedIncomingTxVolumeYearly(value) {
    _expectedIncomingTxVolumeYearly = value;
    notifyListeners();
  }

  String? Function(String?)? expectedIncomingValidator = globalValidator;

  var _addressLine1 = '';

  get addressLine1 => _addressLine1;

  set addressLine1(value) {
    _addressLine1 = value;
    notifyListeners();

  }
  var _addressLine2 = '';

  get addressLine2 => _addressLine2;

  set addressLine2(value) {
    _addressLine2 = value;
    notifyListeners();
  }
  var _city = '';

  get city => _city;

  set city(value) {
    _city = value;
    notifyListeners();

  }
  var _country = '';

  get country => _country.isEmpty ? 'Address country' : _country;

  String? Function(String?)? countryValidator = globalValidator;
  var countryController = TextEditingController(text: '');

  set country(value) {
    countryController.text = value.name + " " + value.flagEmoji;
    _country = value.countryCode;
    notifyListeners();

  }
  var _postalCode = '';

  get postalCode => _postalCode;

  set postalCode(value) {
    _postalCode = value;
    notifyListeners();

  }
  var _province = '';

  get province => _province;

  set province(value) {
    _province = value;
    notifyListeners();

  }

  final updateDataFormKey = GlobalKey<FormState>();

  String? Function(String?)? addressLine1NameValidator = globalValidator;
  String? Function(String?)? addressLine2NameValidator = globalValidator;
  String? Function(String?)? cityNameValidator = globalValidator;
  String? Function(String?)? countryNameValidator = globalValidator;
  String? Function(String?)? postalCodeValidator = globalValidator;
  String? Function(String?)? provinceCodeValidator = globalValidator;


  validateUpdateData(BuildContext context){
    if (updateDataFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Start KYC')),
      );
    }
  }



}