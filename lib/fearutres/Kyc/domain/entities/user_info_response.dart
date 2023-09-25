class UserInfoResponse {
  final String firstName;
  final String lastName;
  final String email;
  final String? nationality;
  final DateOfBirth? dateOfBirth;
  final Mobile mobile;
  final Address? address;
  final String? occupation;
  final String? sourceOfFunds;
  final String? purposeOfAccount;
  final bool? selfPepDeclaration;
  final String? placeOfBirth;
  final String? expectedIncomingTxVolumeYearly;
  final String? expectedOutgoingTxVolumeYearly;
  final Kyc? kyc;
  final String? userId;
  final int? createdAt;
  final String? sourceOfFundsOther;
  final String? purposeOfAccountOther;
  final bool twoFactorEnabled;

  UserInfoResponse({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.nationality,
    required this.dateOfBirth,
    required this.mobile,
    required this.address,
    required this.occupation,
    required this.sourceOfFunds,
    required this.purposeOfAccount,
    required this.selfPepDeclaration,
    required this.placeOfBirth,
    required this.expectedIncomingTxVolumeYearly,
    required this.expectedOutgoingTxVolumeYearly,
    required this.kyc,
    required this.userId,
    required this.createdAt,
    required this.sourceOfFundsOther,
    required this.purposeOfAccountOther,
    required this.twoFactorEnabled,
  });

}

class Address {
  final String addressLine1;
  final dynamic addressLine2;
  final String city;
  final String postalCode;
  final String country;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Address(
        addressLine1: '',
        addressLine2: '',
        city: '',
        postalCode: '',
        country: '',
      );
    }

    return Address(
      addressLine1: json["addressLine1"],
      addressLine2: json["addressLine2"],
      city: json["city"],
      postalCode: json["postalCode"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "postalCode": postalCode,
        "country": country,
      };
}

class DateOfBirth {
  final String month;
  final String day;
  final String year;

  DateOfBirth({
    required this.month,
    required this.day,
    required this.year,
  });

  factory DateOfBirth.fromJson(Map<String, dynamic>? json) {
    if (json == null){
      return DateOfBirth(
        month: '',
        day:  '',
        year: '',
      );
    }

    return DateOfBirth(
      month: json["month"] ?? '',
      day: json["day"] ?? '',
      year: json["year"] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "month": month,
        "day": day,
        "year": year,
      };
}

class Kyc {
  final dynamic details;
  final RejectionComments rejectionComments;
  final bool emailVerified;
  final bool mobileVerified;
  final String status;

  Kyc({
    required this.details,
    required this.rejectionComments,
    required this.emailVerified,
    required this.mobileVerified,
    required this.status,
  });

  factory Kyc.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Kyc(
        details: null,
        rejectionComments: RejectionComments.fromJson(null),
        emailVerified: false,
        mobileVerified: false,
        status: '',
      );
    }

    return Kyc(
      details: json["details"],
      rejectionComments: RejectionComments.fromJson(json["rejectionComments"] ?? {}),
      emailVerified: json["emailVerified"] ?? false,
      mobileVerified: json["mobileVerified"] ?? false,
      status: json["status"] ?? 'NOT_STARTED',
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "details": details,
        "rejectionComments": rejectionComments.toJson(),
        "emailVerified": emailVerified,
        "mobileVerified": mobileVerified,
        "status": status,
      };
}

class RejectionComments {
  final dynamic userComment;
  final dynamic autoComment;

  RejectionComments({
    required this.userComment,
    required this.autoComment,
  });

  factory RejectionComments.fromJson(Map<String, dynamic>? json) {
    if (json == null){
      return RejectionComments(
        userComment:  '',
        autoComment:  '',
      );
    }

    return RejectionComments(
      userComment: json["userComment"] ?? '',
      autoComment: json["autoComment"] ?? '',
    );
  }


  Map<String, dynamic> toJson() =>
      {
        "userComment": userComment,
        "autoComment": autoComment,
      };
}

class Mobile {
  final String countryCode;
  final String number;

  Mobile({
    required this.countryCode,
    required this.number,
  });

  factory Mobile.fromJson(Map<String, dynamic> json) =>
      Mobile(
        countryCode: json["countryCode"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() =>
      {
        "countryCode": countryCode,
        "number": number,
      };
}
