

import 'package:flutter/material.dart';
import 'package:posts_clean_arch/core/sumsub_helper.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/pages/kyc_page.dart';

class KycProvider extends ChangeNotifier {
  final List<Widget> tabBarViews = <Widget>[
    const RegisterInStrigaPage(),
    const VerifyMailPage(),
    const VerifyPhonePage(),
    const UpdateUserPage(),
  ];

  late TabController tabController;

  static var globalValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  };


  var registerFormKey = GlobalKey<FormState>();

  var firstName = '';

  String? Function(String?)? firstNameValidator = globalValidator;

  var lastName = '';
  String? Function(String?)? lastNameValidator = globalValidator;

  var email = '';
  String? Function(String?)? emailValidator = globalValidator;

  var _countryCode = '';

  get countryCode => _countryCode;

  set countryCode(value) {
    _countryCode = "+$value";
    countryCodeController.text = "+ $value";
    notifyListeners();
  }
  String? Function(String?)? countryCodeValidator = globalValidator;

  var countryCodeController = TextEditingController(text: '');

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
    return registerFormKey.currentState!.validate();
  }

  validateRegister(BuildContext context){
    if (registerFormKey.currentState!.validate()) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered on striga')),
      );*/
    }
    notifyListeners();
  }

  var strigaUserId = '';

  moveToVerifyEmail(BuildContext context,RegisterStrigaResponse response){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registered on striga')),
    );
    tabController.animateTo(tabController.index + 1);
    /// TODO: STORE ON LOCAL STORAGE AND TAKE FROM THERE
    strigaUserId = response.userId;
    notifyListeners();
  }
  final emailVFormKey = GlobalKey<FormState>();
  String? Function(String?)? emailVCodeValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (value.length != 6){
      return 'OTP must be 6 digits';
    }

    return null;
  };

  validateEmailVCode(BuildContext context){
    if (emailVFormKey.currentState!.validate()) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email Verified')),
      );*/
    }
    notifyListeners();
  }
  var emailVCode = '';
  bool isValidEmailCode(){
    return emailVFormKey.currentState!.validate();
  }

  setEmailVCode(value){
    emailVCode = value;
    notifyListeners();
  }
  final phoneVFormKey = GlobalKey<FormState>();
  String? Function(String?)? phoneVCodeValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (value.length != 6){
      return 'OTP must be 6 digits';
    }

    return null;
  };

  validatePhoneVCode(BuildContext context){
    if (phoneVFormKey.currentState!.validate()) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Verified')),
      );*/
    }
    notifyListeners();
  }

  moveToVerifyPhone(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verified mail successfully')),
    );
    tabController.animateTo(tabController.index + 1);
    notifyListeners();
  }


  var phoneVCode = '';
  bool isValidPhoneCode(){
    return phoneVFormKey.currentState!.validate();
  }

  setPhoneVCode(value){
    phoneVCode = value;
    notifyListeners();
  }

  moveToUpdateData(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verified phone successfully')),
    );
    tabController.animateTo(tabController.index + 1);
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



  String? Function(String?)? addressLine1NameValidator = globalValidator;
  String? Function(String?)? addressLine2NameValidator = globalValidator;
  String? Function(String?)? cityNameValidator = globalValidator;
  String? Function(String?)? countryNameValidator = globalValidator;
  String? Function(String?)? postalCodeValidator = globalValidator;
  String? Function(String?)? provinceCodeValidator = globalValidator;

  final updateDataFormKey = GlobalKey<FormState>();


  validateUpdateData(BuildContext context){
    if (updateDataFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Start KYC')),
      );

    }

    notifyListeners();
  }


  var birthdayController = TextEditingController(text: '');

  var _birthday= '';

  get birthday => _birthday.isEmpty;

  set birthday(value) {
    _birthday = value;
    birthdayController.text = value;
    notifyListeners();
  }

  String? Function(String?)? birthdayValidator = globalValidator;


  bool pepYes = false;
  bool pepNo = false;

  bool pepSelected = false;
  bool pepRequired = true;

  declareYes(bool? yes){
    if (yes!){
      pepYes = true;
      pepNo = false;
    }
    if (pepYes){
      pepSelected = true;
      pepRequired = false;
    } else if (pepNo) {
      pepSelected = false;
      pepRequired = false;
    } else {
      pepRequired = true;
    }
    notifyListeners();
  }

  declareNo(bool? no){
    if (no!){
      pepYes = false;
      pepNo = true;
    }
    if (pepYes){
      pepSelected = true;
      pepRequired = false;
    } else if (pepNo) {
      pepSelected = false;
      pepRequired = false;
    } else {
      pepRequired = true;
    }
    notifyListeners();
  }

  void startKYC(BuildContext context) {
    ///TODO CALL START KYC
    var token = '';
    SumsubHelper.launchSDK(token);
  }

  void checkTheRightFlow() {
    ///TODO: GET USER FROM LOCAL STORAGE
    String? strigaUser;
    if (strigaUser != null){
      ///TODO: CALL GET USER INFO
      bool emailVerified = true;
      bool phoneVerified = true;
      String kycStatus = 'NOT_STARTED';

      if (kycStatus == 'INITIALIZED'){
        ///TODO: CALL START KYC
        var token = '';
        SumsubHelper.launchSDK(token);
      } else if (kycStatus == 'NOT_STARTED') {
        if (emailVerified & phoneVerified){
          tabController.animateTo(3);
        } else {
          if (!emailVerified & !phoneVerified){
            tabController
                .animateTo(1);
          }
          if (emailVerified & !phoneVerified){
            tabController.animateTo(2);
          }
        }
      } else {
        ///TODO SHOW PAGE WITH THE CURRENT KYC STATUS
      }
    }
  }

}

