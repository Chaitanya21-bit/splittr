import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
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

  SplashBloc(this._authRepository, this._userRepository)
    : super(const SplashState.initial(store: SplashStateStore()));

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_, Emitter<SplashState> emit) async {
    final (_, userOrFailure) = await (_showSplash(), _checkAuth()).wait;

    userOrFailure.fold(
      (_) => emit(SplashState.userUnauthorized(store: state.store)),
      (user) =>
          emit(SplashState.userAuthorized(store: state.store, user: user)),
    );
  }

  Future<void> _showSplash() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<Either<Failure, User>> _checkAuth() async {
    if (_authRepository.isUserSignedIn) {
      final userOrFailure = await _userRepository.getUser();

      return userOrFailure.fold((_) {
        _authRepository.logout();

        return userOrFailure;
      }, right);
    }

    return left(const Failure(message: 'Not Signed In'));
  }

  @override
  void started({Map<String, dynamic>? args}) {
    add(const SplashEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
