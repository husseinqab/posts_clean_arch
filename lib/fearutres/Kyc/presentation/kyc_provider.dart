import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:posts_clean_arch/core/httpHelper.dart';
import 'package:posts_clean_arch/core/sumsub_helper.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/user_info_response.dart';
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
  var nextIsDisabled = false;
  void enableNext(){
    nextIsDisabled = false;
  }

  void disableNext(){
    nextIsDisabled = true;
  }
  validateRegister(BuildContext context) {
    if (registerFormKey.currentState!.validate()) {
      disableNext();
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
    enableNext();
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
      disableNext();
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
      disableNext();
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Verified')),
      );*/
    }
    notifyListeners();
  }

  moveToVerifyPhone(BuildContext context) {
    enableNext();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verified mail successfully')),
    );
    tabController.animateTo(tabController.index + 1);
    currentIndex = 3;
    enableNext();
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
    enableNext();
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
    disableNext();
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
      if (apiResponse.statusCode == 200) {
        // Navigator.pushNamed(context, "/FinalKYC");
        token = apiResponse.data["token"];
        disableNext();
        SumsubHelper.launchSDK(token);
      } else if (apiResponse.statusCode == 30032 || apiResponse.statusCode == 400) {
        tabController.animateTo(4);
      }
    } else {
      ///TODO: Do something here
      // Navigator.pushNamed(context, "/FinalKYC");
    }
    notifyListeners();
  }

  var currentIndex = 0;

  void checkTheRightFlow(BuildContext context,UserInfoResponse? userInfo) async {
    ///TODO: GET USER FROM LOCAL STORAGE
    String? strigaUser;
    bool emailVerified = false;
    bool phoneVerified = false;
    String kycStatus = 'NOT_STARTED';
    if (userInfo != null){
       strigaUser = userInfo.userId;
      strigaUserId= userInfo.userId!;
      emailVerified = userInfo.kyc!.emailVerified;
      phoneVerified = userInfo.kyc!.mobileVerified;
      kycStatus = userInfo.kyc!.status;
    }
    if (strigaUser != null) {

      if (kycStatus == 'INITIATED') {
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
        ///TODO SHOW PAGE WITH THE CURRENT KYC STATUS
      }
    } else {
      tabController.animateTo(1);
      currentIndex = 1;
    }
    notifyListeners();
  }
}
