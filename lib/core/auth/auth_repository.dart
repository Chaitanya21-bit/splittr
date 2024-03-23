import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/i_auth_repository.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

@Singleton(as: IAuthRepository)
final class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepository(this._firebaseAuth);

  @override
  bool get isUserSignedIn => _firebaseAuth.currentUser != null;

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    required OtpSentCallback onOtpSent,
    required VerificationFailedCallback onVerificationFailed,
    int? forceResendingToken,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          onVerificationFailed(e.message ?? 'Failed');
        },
        codeSent: onOtpSent,
        codeAutoRetrievalTimeout: (_) {},
        forceResendingToken: forceResendingToken,
      );
    } catch (_) {}
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String otp,
    required String verificationId,
  }) {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
  }
}
