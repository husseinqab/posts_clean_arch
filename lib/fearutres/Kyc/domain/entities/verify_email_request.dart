class VerifyEmailRequest {
  final String userId;
  final String verificationId;

  VerifyEmailRequest({
    required this.userId,
    required this.verificationId,
  });

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) => VerifyEmailRequest(
    userId: json["userId"],
    verificationId: json["verificationId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "verificationId": verificationId,
  };
}