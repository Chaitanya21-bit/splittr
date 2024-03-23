import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_page/base_page.dart';
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/otp_verification/presentation/blocs/otp_verification_bloc.dart';
import 'package:splittr/utils/bloc_utils/bloc_utils.dart';

part 'otp_verification_form.dart';

class OtpVerificationPage extends BasePage<OtpVerificationBloc> {
  const OtpVerificationPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        buildWhen: (_,__){
          return false;
        },
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, OtpVerificationState state) {}

  Widget _handleWidget(BuildContext context, OtpVerificationState state) {
    return const _OtpVerificationForm();
  }

  @override
  OtpVerificationBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<OtpVerificationBloc>()..started(args: args);
  }
}
