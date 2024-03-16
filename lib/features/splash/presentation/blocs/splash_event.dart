part of 'splash_bloc.dart';

@freezed
class SplashEvent extends BaseEvent with _$SplashEvent {
  const factory SplashEvent.started() = _Started;
}
