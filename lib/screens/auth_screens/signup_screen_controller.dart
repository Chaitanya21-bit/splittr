import 'package:flutter/material.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/utils/get_provider.dart';

import '../../utils/toasts.dart';

class SignUpScreenController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPasswordController = TextEditingController();

  late final FirebaseAuthProvider authProvider;

  final BuildContext context;

  SignUpScreenController(this.context) {
    authProvider = getProvider<FirebaseAuthProvider>(context);
  }

  bool _validate() {
    if (emailController.text.isEmpty) {
      showToast("Enter email");
      return false;
    }
    if (nameController.text.isEmpty) {
      showToast("Enter name");
      return false;
    }
    if (aliasController.text.isEmpty) {
      showToast("Enter alias");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showToast("Enter password");
      return false;
    }
    if (cnfPasswordController.text != passwordController.text) {
      showToast("Confirm password should be same as password");
      return false;
    }
    return true;
  }


  Future<void> submit() async {
    if (!_validate()) {
      return;
    }
    authProvider.signUpWithEmail(
      context,
      email: emailController.text,
      password: passwordController.text,
      cnfPassword: cnfPasswordController.text,
      name: nameController.text,
      alias: aliasController.text,
    );
  }

  void clear() {
    emailController.dispose();
    nameController.dispose();
    aliasController.dispose();
    passwordController.dispose();
    cnfPasswordController.dispose();
  }
}
