import 'package:fpdart/fpdart.dart';
import 'package:splittr/core/failure/failure.dart';

typedef OtpSentCallback = void Function(
  String verificationId,
  int? forceResendingToken,
);

typedef VerificationFailedCallback = void Function(String message);

typedef FutureEitherFailure<T> = Future<Either<Failure, T>>;

typedef FutureEitherFailureVoid = FutureEitherFailure<Unit>;
