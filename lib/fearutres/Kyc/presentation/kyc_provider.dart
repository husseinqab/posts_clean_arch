

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:posts_clean_arch/core/httpHelper.dart';
import 'package:posts_clean_arch/core/sumsub_helper.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/pages/kyc_page.dart';

class KycProvider extends ChangeNotifier {
  final List<Widget> tabBarViews = <Widget>[
    const RegisterInStrigaPage(),
    const VerifyMailPage(),
    const VerifyPhonePage(),
    const UpdateUserPage()
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

  var countryCode = '';

  setCountryCode(value) {
    countryCode = "+$value";
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

  var strigaUserId = '3a4e6072-9a66-4ff5-97b7-9393edc9103c';

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

  var documentIssuingCountry = '';

  setDocumentIssuingCountry(value) {
    documentIssueController.text = value.name + " " + value.flagEmoji;
    documentIssuingCountry = value.countryCode;
    notifyListeners();
  }

  String? Function(String?)? documentIssueValidator = globalValidator;

  var nationalityController = TextEditingController(text: '');

  var nationality = '';

  setNationality(value) {
    nationalityController.text = value.name + " " + value.flagEmoji;
    nationality = value.countryCode;
    notifyListeners();
  }

  String? Function(String?)? nationalityValidator = globalValidator;

  var occupation = '';

  String? Function(String?)? occupationValidator = globalValidator;


  setOccupation(value) {
    occupation = value;
    notifyListeners();
  }
  var sourceOfFunds = '';


  String? Function(String?)? sourceOfFundsValidator = globalValidator;


  setSourceOfFunds(value) {
    sourceOfFunds = value;
    notifyListeners();
  }
  var purposeOfAccount = '';

  setPurposeOfAccount(value) {
    purposeOfAccount = value;
    notifyListeners();
  }
  var placeOfBirth = '';

  var placeOfBirthController = TextEditingController(text: '');


  setPlaceOfBirth(value) {
    placeOfBirthController.text = value.name + " " + value.flagEmoji;
    placeOfBirth = value.countryCode;
    notifyListeners();
  }

  String? Function(String?)? placeOfBirthValidator = globalValidator;

  var expectedOutgoingTxVolumeYearly = '';


  setExpectedOutgoingTxVolumeYearly(value) {
    expectedOutgoingTxVolumeYearly = value;
    notifyListeners();
  }

  String? Function(String?)? expectedOutgoingValidator = globalValidator;

  var expectedIncomingTxVolumeYearly = '';


  setExpectedIncomingTxVolumeYearly(value) {
    expectedIncomingTxVolumeYearly = value;
    notifyListeners();
  }

  String? Function(String?)? expectedIncomingValidator = globalValidator;

  var addressLine1 = '';


  setAddressLine1(value) {
    addressLine1 = value;
    notifyListeners();

  }
  var addressLine2 = '';


  setAddressLine2(value) {
    addressLine2 = value;
    notifyListeners();
  }
  var city = '';

  setCity(value) {
    city = value;
    notifyListeners();

  }
  var country = '';

  String? Function(String?)? countryValidator = globalValidator;
  var countryController = TextEditingController(text: '');

  setCountry(value) {
    countryController.text = value.name + " " + value.flagEmoji;
    country = value.countryCode;
    notifyListeners();

  }
  var postalCode = '';

  setPostalCode(value) {
    postalCode = value;
    notifyListeners();

  }
  var province = '';

  setProvince(value) {
    province = value;
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
/*    if (updateDataFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Start KYC')),
      );
    }*/
    notifyListeners();
  }


  var birthdayController = TextEditingController(text: '');

  dynamic birthday;

  setBirthday(value) {
    var formatted = DateFormat('yyyy-MM-dd').format(value!);
    birthday = value;
    birthdayController.text = formatted;
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

  void startKYC(BuildContext context) async {
    ///TODO CALL START KYC
    var token = '';
    final Client client = Client();
     var accesstoken = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IlpRUEg2UU1FTlhLNE5LOTRaTFlSOEIwRVMwRzNHOEc2OFdHQVVGN0QiLCJ0eXAiOiJhdCtqd3QifQ.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjE0OTJlYmYxLTI0N2UtNGVkYi1iOWE4LTc5YmFhNGU2OGZmNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJzYXJhaC5zbGltYW4yMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoic2FyYWguc2xpbWFuMjIyQGdtYWlsLmNvbSIsInJlZmVycmFsIjoiZGZpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsIm9pX3Byc3QiOiJ0ZXN0LWRvdWJsZXdhbGxldC13ZWIiLCJpc3MiOiJodHRwczovL3NhbmRib3guZG91Ymxld2FsbGV0LmlvLyIsIm9pX2F1X2lkIjoiNDIzZjVkNTItMGZhNy00N2Y1LTllNmMtMjBlMjZhMDk0NmZiIiwic3ViIjoiMTQ5MmViZjEtMjQ3ZS00ZWRiLWI5YTgtNzliYWE0ZTY4ZmY3IiwibmFtZSI6InNhcmFoLnNsaW1hbjIyMkBnbWFpbC5jb20iLCJlbWFpbCI6InNhcmFoLnNsaW1hbjIyMkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJyb2xlIjoiVXNlciIsImNsaWVudF9pZCI6InRlc3QtZG91Ymxld2FsbGV0LXdlYiIsIm9pX3Rrbl9pZCI6IjA1ZTY3YmI4LTkwZjMtNGUzYy04MGE3LWI2YzQ0NzY2Y2NhOCIsInNjb3BlIjoicGhvbmUgZW1haWwgcHJvZmlsZSByb2xlcyIsImp0aSI6ImI1YTE5MGEyLWM2NTEtNDY4ZS05NmM4LWY1ODUyYWZkODk3MiIsImV4cCI6MTY5NTMzMzU4NiwiaWF0IjoxNjk1MzMxNzg2fQ.UwvvaY1Jy8qn3GIESYJHlczzxn5vMRzTJiyAxb5cGCTB1hIEACuFrf2WP5OZFEhPTNCBbhH1Hr_8N5rcRwMpGX7HYwsExGT6E23s3jy1H6VGkkJZdVzQFiW1VKbq_PDOeZZ4bkkhi2kqi15WVOIlBCpCWryvVMJ9RaQLqErz5w0CHrKijgt4Tt1c2TVPuHq0qcuet77W6rRMWPUgqMDAmAvPPMCEUa1SDRGg7lEXJLiVaZ3FXQMu2Lq4Ru4DGbpm0OK_TnxwgD4vyeZUAw7Yy6UZu5EUeeBH_jrCY3TBfFKWDzvPLw1kgxM8-m1c7PesdQBiOFUvO4IcC3bu2a9y7w';
    final headers = {'Content-Type': 'application/json',
      'Authorization': "Bearer $accesstoken"};
    Response response = await client.post(Uri.parse('https://sandbox.doublewallet.io/api/Users/StartKyc'), body:jsonEncode({
      "userId": strigaUserId,
      "clientId":"Double-finance"
    }),headers: headers);

    if (response.statusCode == 200){
      var apiResponse = apiResponseFromJson(response.body);
      if (response.statusCode == 200){
       // Navigator.pushNamed(context, "/FinalKYC");
        token = apiResponse.data["token"];
        SumsubHelper.launchSDK(token);
      } else if (response.statusCode == 30032) {
        tabController.animateTo(3);
      }
    } else {
     // Navigator.pushNamed(context, "/FinalKYC");
    }
    notifyListeners();
  }

  void checkTheRightFlow(BuildContext context) {
    ///TODO: GET USER FROM LOCAL STORAGE
    String? strigaUser;
    if (strigaUser != null){
      ///TODO: CALL GET USER INFO
      bool emailVerified = false;
      bool phoneVerified = false;
      String kycStatus = 'NOT_STARTED';

      if (kycStatus == 'INITIATED'){
        ///TODO: CALL START KYC
       // Navigator.pushNamed(context, "/FinalKYC");
        startKYC(context);
      } else if (kycStatus == 'NOT_STARTED') {
        if (emailVerified & phoneVerified){
          startKYC(context);
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
        tabController.animateTo(4);
        ///TODO SHOW PAGE WITH THE CURRENT KYC STATUS
      }
    }
  }

}

