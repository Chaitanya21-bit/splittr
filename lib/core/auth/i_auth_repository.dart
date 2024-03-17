import 'package:splittr/utils/typedefs/typedefs.dart';

abstract interface class IAuthRepository {
  bool get isUserSignedIn;

  Future<void> sendOtp(String phoneNumber, OtpSentCallback onOtpSent);
}
