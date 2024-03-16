import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

@injectable
final class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(
          const SplashState.initial(
            store: SplashStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<SplashEvent>((event, emit) {
      switch (event) {
        case Started():
          changeLoaderState(emit: emit, loading: true);
          emit(
            SplashState.initial(store: state.store.copyWith(loading: false)),
          );
      }
    });
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const SplashEvent.started());
  }
}
