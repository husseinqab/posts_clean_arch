class VerifyIdentityRequest {
  final String userId;
  final String? verificationId;
  final String? verificationCode;

  VerifyIdentityRequest(
      {required this.userId, this.verificationId, this.verificationCode});

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "verificationId": verificationId,
        "verificationCode": verificationCode
      };
}
