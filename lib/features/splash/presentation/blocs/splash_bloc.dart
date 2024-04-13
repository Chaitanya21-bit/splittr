import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/core/user/domain/domain/repositories/i_user_repository.dart';
import 'package:splittr/core/user/domain/models/user.dart';

part 'splash_bloc.freezed.dart';

part 'splash_event.dart';

part 'splash_state.dart';

@injectable
final class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  SplashBloc(
    this._authRepository,
    this._userRepository,
  ) : super(
          const SplashState.initial(
            store: SplashStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_SplashShown>(_onSplashShown);
    on<_AuthChecked>(_onAuthChecked);
  }

  void _onStarted(
    _,
    Emitter<SplashState> emit,
  ) {
    splashShown();
    authChecked();
  }

  Future<void> _onSplashShown(
    _,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    emit(
      SplashState.showedSplash(
        store: state.store.copyWith(
          splashShown: true,
        ),
      ),
    );
  }

  Future<void> _onAuthChecked(
    _,
    Emitter<SplashState> emit,
  ) async {
    if (_authRepository.isUserSignedIn) {
      final userOrFailure =
          await _userRepository.fetchUser(_authRepository.userId ?? '');
      return userOrFailure.fold(
        (_) {
          _authRepository.logout();

          emit(
            SplashState.userNotFound(
              store: state.store.copyWith(
                authChecked: true,
                isAuthorized: false,
              ),
            ),
          );
        },
        (user) => emit(
          SplashState.userAuthorized(
            store: state.store.copyWith(
              authChecked: true,
              isAuthorized: true,
              user: user,
            ),
          ),
        ),
      );
    }

    emit(
      SplashState.userUnauthorized(
        store: state.store.copyWith(
          authChecked: true,
          isAuthorized: false,
        ),
      ),
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const SplashEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;

  void splashShown() {
    add(const SplashEvent.splashShown());
  }

  void authChecked() {
    add(const SplashEvent.authChecked());
  }
}
