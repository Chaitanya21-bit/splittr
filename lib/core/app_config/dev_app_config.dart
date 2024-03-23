part of 'i_app_config.dart';

final class DevAppConfig implements IAppConfig {
  const DevAppConfig();

  @override
  Env get env => Env.dev;

  @override
  FirebaseOptions get firebaseOptions =>
      firebase_options_dev.DefaultFirebaseOptions.currentPlatform;

  @override
  String get appName => 'Splittr Dev';
}
