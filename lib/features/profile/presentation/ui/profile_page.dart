import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base/base_page/base_page.dart';
import 'package:splittr/features/profile/presentation/blocs/profile_bloc.dart';

part 'profile_form.dart';

class ProfilePage extends BasePage<ProfileBloc> {
  const ProfilePage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, ProfileState state) {}

  Widget _handleWidget(BuildContext context, ProfileState state) {
    return const _ProfileForm();
  }
}
