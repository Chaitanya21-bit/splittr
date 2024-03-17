import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/i_auth_repository.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

@Singleton(as: IAuthRepository)
final class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepository(this._firebaseAuth);

  @override
  bool get isUserSignedIn => _firebaseAuth.currentUser != null;

  @override
  Future<void> sendOtp(String phoneNumber, OtpSentCallback onOtpSent) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (_) {},
      verificationFailed: (_) {},
      codeSent: onOtpSent,
      codeAutoRetrievalTimeout: (_) {},
    );
  }
}
