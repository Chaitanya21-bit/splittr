import 'package:firebase_core/firebase_core.dart';
import 'package:splittr/constants/env/env.dart';
import 'package:splittr/core/firebase/firebase_options_dev.dart'
    as firebase_options_dev;
import 'package:splittr/core/firebase/firebase_options_prod.dart'
    as firebase_options_prod;

part 'dev_app_config.dart';

part 'prod_app_config.dart';

IAppConfig appConfig = const DevAppConfig();

sealed class IAppConfig {
  Env get env;

  FirebaseOptions get firebaseOptions;

  factory IAppConfig.init(Env env) {
    return switch (env) {
      Env.dev => const DevAppConfig(),
      Env.prod => const ProdAppConfig(),
    };
  }
}
