part of 'splash_bloc.dart';

@freezed
class SplashEvent extends BaseEvent with _$SplashEvent {
  const SplashEvent._();

  const factory SplashEvent.started() = _Started;
}
