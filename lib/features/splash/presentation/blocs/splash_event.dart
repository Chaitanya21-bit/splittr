part of 'splash_bloc.dart';

@freezed
sealed class SplashEvent extends BaseEvent with _$SplashEvent {
  const factory SplashEvent.started() = Started;
}
