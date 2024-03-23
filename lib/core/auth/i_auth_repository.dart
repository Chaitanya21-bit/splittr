import 'package:fpdart/fpdart.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

abstract interface class IAuthRepository {
  bool get isUserSignedIn;

  Future<void> sendOtp({
    required String phoneNumber,
    required OtpSentCallback onOtpSent,
    required VerificationFailedCallback onVerificationFailed,
    int? forceResendingToken,
  });

  Future<Either<Failure,void>> verifyOtp({
    required String otp,
    required String verificationId,
  });
}
