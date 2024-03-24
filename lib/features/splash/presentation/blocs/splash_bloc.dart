import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'splash_bloc.freezed.dart';

part 'splash_event.dart';

part 'splash_state.dart';

@injectable
final class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final IAuthRepository _authRepository;

  SplashBloc(this._authRepository)
      : super(
          const SplashState.initial(
            store: SplashStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_Started event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    if (_authRepository.isUserSignedIn) {
      return emit(SplashState.userAuthorized(store: state.store));
    }
    emit(SplashState.userUnauthorized(store: state.store));
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const SplashEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
