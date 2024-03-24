import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

@Singleton(as: IAuthRepository)
final class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepository(this._firebaseAuth);

  @override
  bool get isUserSignedIn => _firebaseAuth.currentUser != null;

  @override
  String? get userId => _firebaseAuth.currentUser?.uid;

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
  FutureEitherFailureVoid verifyOtp({
    required String otp,
    required String verificationId,
  }) async {
    try {
      final authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _firebaseAuth.signInWithCredential(authCredential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return switch (e.message) {
        // TODO(Saurabh): Add proper message
        'account-exists-with-different-credential' =>
          left(const Failure(message: 'Failed')),
        'invalid-credential' => left(const Failure(message: 'Failed')),
        'operation-not-allowed' => left(const Failure(message: 'Failed')),
        'user-disabled' => left(const Failure(message: 'Failed')),
        'user-not-found' => left(const Failure(message: 'Failed')),
        'wrong-password' => left(const Failure(message: 'Failed')),
        'invalid-verification-code' => left(const Failure(message: 'Failed')),
        'invalid-verification-id' => left(const Failure(message: 'Failed')),
        _ => left(const Failure(message: 'Failed'))
      };
    }
  }
}
