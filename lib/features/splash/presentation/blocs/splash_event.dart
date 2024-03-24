part of 'splash_bloc.dart';

@freezed
class SplashEvent extends BaseEvent with _$SplashEvent {
  const factory SplashEvent.started() = _Started;

  const factory SplashEvent.splashShown() = _SplashShown;

  const factory SplashEvent.authChecked() = _AuthChecked;
}
