typedef OtpSentCallback = void Function(
  String verificationId,
  int? forceResendingToken,
);

typedef VerificationFailedCallback = void Function(String message);
