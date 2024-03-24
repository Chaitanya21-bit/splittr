import 'package:splittr/utils/typedefs/typedefs.dart';

abstract interface class IAuthRepository {
  bool get isUserSignedIn;

  String? get userId;

  Future<void> sendOtp({
    required String phoneNumber,
    required OtpSentCallback onOtpSent,
    required VerificationFailedCallback onVerificationFailed,
    int? forceResendingToken,
  });

  FutureEitherFailureVoid verifyOtp({
    required String otp,
    required String verificationId,
  });

  Future<void> logout();
}
