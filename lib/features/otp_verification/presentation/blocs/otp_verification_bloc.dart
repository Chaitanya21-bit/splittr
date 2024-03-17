import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
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

  void _onStarted(_Started event, Emitter<OtpVerificationState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const OtpVerificationEvent.started());
  }
}
