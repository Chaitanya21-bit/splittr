import 'package:flutter/material.dart';
import 'package:splitter/constants/assets.dart';
import 'package:splitter/screens/base.dart';
import 'package:splitter/screens/splash_screen/splash_screen_controller.dart';

import '../../utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashScreenController controller;

  @override
  void initState() {
    controller = SplashScreenController(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BaseView(
      controller: controller,
      builder: (context, controller, _) => Scaffold(
        body: Center(
          child: Image.asset(Assets.splittrLogo),
        ),
      ),
    );
  }
}
