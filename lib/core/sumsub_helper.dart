

import 'dart:async';
import 'dart:ui';

import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';
SNSMobileSDK? snsMobileSDK;

class SumsubHelper {
  static void launchSDK(String token) async {

    // From your backend get an access token for the applicant to be verified.
    // The token must be generated with `levelName` and `userId`,
    // where `levelName` is the name of a level configured in your dashboard.
    //
    // The sdk will work in the production or in the sandbox environment
    // depend on which one the `accessToken` has been generated on.
    //
     String accessToken = token;

    // The access token has a limited lifespan and when it's expired, you must provide another one.
    // So be prepared to get a new token from your backend.
    onTokenExpiration() async {
      // call your backend to fetch a new access token (this is just an example)
      return Future<String>.delayed(Duration(seconds: 2), () => "your new access token");
    }

    onStatusChanged(SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
      print("The SDK status was changed: $prevStatus -> $newStatus");
    }

    final snsMobileSDK = SNSMobileSDK.init(accessToken, onTokenExpiration)
        .withHandlers( // optional handlers
        onStatusChanged: onStatusChanged
    )
        .withDebug(true) // set debug mode if required
        .withLocale(const Locale("en")) // optional, for cases when you need to override the system locale
        .build();

    final SNSMobileSDKResult result = await snsMobileSDK.launch();

    print("Completed with result: $result");
  }
}