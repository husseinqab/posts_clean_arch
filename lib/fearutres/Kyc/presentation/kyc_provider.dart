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
    const CheckTheRightFlow(),
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

  setFirstName(value) {
    firstName = value;
    notifyListeners();
  }

  setLastName(value) {
    lastName = value;
    notifyListeners();
  }

  setEmail(value) {
    email = value;
    notifyListeners();
  }

  setPhone(value) {
    phone = value;
    notifyListeners();
  }

  bool isValidRegister() {
    return registerFormKey.currentState!.validate();
  }

  validateRegister(BuildContext context) {
    if (registerFormKey.currentState!.validate()) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered on striga')),
      );*/
    }
    notifyListeners();
  }

  var strigaUserId = '3a4e6072-9a66-4ff5-97b7-9393edc9103c';

  moveToVerifyEmail(BuildContext context, RegisterStrigaResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registered on striga')),
    );
    tabController.animateTo(tabController.index + 1);
    currentIndex = 2;

    /// TODO: STORE ON LOCAL STORAGE AND TAKE FROM THERE
    strigaUserId = response.userId;
    notifyListeners();
  }

  final emailVFormKey = GlobalKey<FormState>();
  String? Function(String?)? emailVCodeValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }

    return null;
  };

  validateEmailVCode(BuildContext context) {
    if (emailVFormKey.currentState!.validate()) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email Verified')),
      );*/
    }
    notifyListeners();
  }

  var emailVCode = '';

  bool isValidEmailCode() {
    return emailVFormKey.currentState!.validate();
  }

  setEmailVCode(value) {
    emailVCode = value;
    notifyListeners();
  }

  final phoneVFormKey = GlobalKey<FormState>();
  String? Function(String?)? phoneVCodeValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }

    return null;
  };

  validatePhoneVCode(BuildContext context) {
    if (phoneVFormKey.currentState!.validate()) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Verified')),
      );*/
    }
    notifyListeners();
  }

  moveToVerifyPhone(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verified mail successfully')),
    );
    tabController.animateTo(tabController.index + 1);
    currentIndex = 3;
    notifyListeners();
  }

  var phoneVCode = '';

  bool isValidPhoneCode() {
    return phoneVFormKey.currentState!.validate();
  }

  setPhoneVCode(value) {
    phoneVCode = value;
    notifyListeners();
  }

  moveToUpdateData(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verified phone successfully')),
    );
    tabController.animateTo(tabController.index + 1);
    currentIndex = 4;
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

  validateUpdateData(BuildContext context) {
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

  declareYes(bool? yes) {
    if (yes!) {
      pepYes = true;
      pepNo = false;
    }
    if (pepYes) {
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

  declareNo(bool? no) {
    if (no!) {
      pepYes = false;
      pepNo = true;
    }
    if (pepYes) {
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
    ///CALLED THIS API LIKE THIS BECAUSE I JUST NEED THE TOKEN
    var token = '';
    final Client client = Client();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $globalAccessToken"
    };
    Response response = await client.post(
        Uri.parse('https://sandbox.doublewallet.io/api/Users/StartKyc'),
        body:
            jsonEncode({"userId": strigaUserId, "clientId": "Double-finance"}),
        headers: headers);

    if (response.statusCode == 200) {
      var apiResponse = apiResponseFromJson(response.body);
      if (response.statusCode == 200) {
        // Navigator.pushNamed(context, "/FinalKYC");
        token = apiResponse.data["token"];
        SumsubHelper.launchSDK(token);
      } else if (response.statusCode == 30032) {
        tabController.animateTo(4);
      }
    } else {
      // Navigator.pushNamed(context, "/FinalKYC");
    }
    notifyListeners();
  }

  var currentIndex = 0;

  void checkTheRightFlow(BuildContext context) async {
    ///TODO: GET USER FROM LOCAL STORAGE
    String? strigaUser = 'dd';
    if (strigaUser != null) {
      ///TODO: CALL GET USER INFO
      bool emailVerified = true;
      bool phoneVerified = true;
      String kycStatus = 'NOT_STARTED';

      if (kycStatus == 'INITIATED') {
        ///TODO: CALL START KYC
        // Navigator.pushNamed(context, "/FinalKYC");
        startKYC(context);
      } else if (kycStatus == 'NOT_STARTED') {
        if (emailVerified & phoneVerified) {
          startKYC(context);
        } else {
          if (!emailVerified & !phoneVerified) {
            tabController.animateTo(2);
            currentIndex = 2;
          }
          if (emailVerified & !phoneVerified) {
            tabController.animateTo(3);
            currentIndex = 3;
          }
        }
      } else {
        //tabController.animateTo(4);
        ///TODO SHOW PAGE WITH THE CURRENT KYC STATUS
      }
    } else {
      tabController.animateTo(1);
      currentIndex = 1;
    }
    notifyListeners();
  }
}


var globalAccessToken = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IlNKOTcwU1dSQ0xTSjdFS0hPRTdKX0k0R05YS1MtS0tHVUhZU0hNQkkiLCJ0eXAiOiJhdCtqd3QifQ.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjIxZjA2MThmLWQ4YzQtNDliMC1hMjEwLTUwNTI2OGYxZjJlZCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJreWMxQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Imt5YzFAZ21haWwuY29tIiwicmVmZXJyYWwiOiJkZmkiLCJvaV9wcnN0IjoidGVzdC1kb3VibGV3YWxsZXQtd2ViIiwiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LmRvdWJsZXdhbGxldC5pby8iLCJvaV9hdV9pZCI6IjlmZmI2YzUwLTJkMGMtNDk0Yi1iNzI1LTM2NTM2ZTI2NWY2ZCIsInN1YiI6IjIxZjA2MThmLWQ4YzQtNDliMC1hMjEwLTUwNTI2OGYxZjJlZCIsIm5hbWUiOiJreWMxQGdtYWlsLmNvbSIsImVtYWlsIjoia3ljMUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJjbGllbnRfaWQiOiJ0ZXN0LWRvdWJsZXdhbGxldC13ZWIiLCJvaV90a25faWQiOiI4ZjA0ZTk4Ny1lNzZjLTRhYTEtYWVkOC05N2M0MjE1Y2Y5M2IiLCJzY29wZSI6InBob25lIGVtYWlsIHByb2ZpbGUgcm9sZXMiLCJqdGkiOiI1MGIzM2JhNi05NDM2LTRkZWUtYWNiZC02NWZlYTM1MmQ1ZWQiLCJleHAiOjE2OTU0NjU2MDYsImlhdCI6MTY5NTQ2MzgwNn0.WEQAf7uIa2sKp4_-AjppxccxTa-JxzX43mvNHJ6gTXwPdzjnsYqaYGXzW50V67gGLoP3-miQqdsEwifV2jdvKo5eAs0v3c26caNVtE4yZsZugHFAGf4CgPzi1lgQjl0JWnm6gak3CDGs8Fl7ozUsZ6rcXN9xGCuetvnHP9_oBntCmpfoXYqES7TsMsIOxfILE3bgKXG0jWGK62ftut8Wh3rXO3bhX1zyN1_hSApHUbC5f7hutk9FAJhYyGC23_IMXccaXkUw026MRbCjI-6s0oMKxU3-VM47hM26iUozFFMWNtIM89MA1zSx4tfF6CcJ2B5209kd6UzJZPC60JQtmg';

