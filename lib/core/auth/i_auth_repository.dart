import 'package:splittr/utils/typedefs/typedefs.dart';

abstract interface class IAuthRepository {
  bool get isUserSignedIn;

  void sendOtp(String phoneNumber, OtpSentCallback onOtpSent);
}
