import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'otp_verification_bloc.freezed.dart';
part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

@injectable
final class OtpVerificationBloc
    extends BaseBloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc()
      : super(
          const OtpVerificationState.initial(
            store: OtpVerificationStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<OtpVerificationState> emit) {
    emit(
      OtpVerificationState.initial(
        store: state.store.copyWith(
          verificationId: event.verificationId,
          forceResendingToken: event.forceResendingToken,
        ),
      ),
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    final verificationId = args?[StringConstants.verificationId] as String?;
    final forceResendingToken =
        args?[StringConstants.forceResendingToken] as int?;

    add(
      OtpVerificationEvent.started(
        verificationId: verificationId,
        forceResendingToken: forceResendingToken,
      ),
    );
  }

  @override
  bool get isLoading => state.store.loading;
}
