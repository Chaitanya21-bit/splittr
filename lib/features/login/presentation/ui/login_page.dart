import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/base_page/base_page.dart';
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/login/presentation/blocs/login_bloc.dart';
import 'package:splittr/utils/bloc_utils/bloc_utils.dart';

part 'login_form.dart';

class LoginPage extends BasePage<LoginBloc> {
  const LoginPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, LoginState state) {
    return switch (state) {
      OtpSent _ => _navigateToLoginOtpVerificationPage(
          context: context,
          verificationId: state.verificationId,
          forceResendingToken: state.forceResendingToken,
        ),
      _ => () {},
    };
  }

  Widget _handleWidget(BuildContext context, LoginState state) {
    return const _LoginForm();
  }

  @override
  LoginBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<LoginBloc>()..started();
  }

  void _navigateToLoginOtpVerificationPage({
    required BuildContext context,
    required String verificationId,
    int? forceResendingToken,
  }) {
    RouteHandler.push(
      context,
      RouteId.otpVerification,
      args: {
        StringConstants.verificationId: verificationId,
        StringConstants.forceResendingToken: forceResendingToken,
      },
    );
  }
}
