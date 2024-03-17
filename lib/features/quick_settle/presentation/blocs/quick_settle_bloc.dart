import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'quick_settle_bloc.freezed.dart';
part 'quick_settle_event.dart';
part 'quick_settle_state.dart';

@injectable
final class QuickSettleBloc
    extends BaseBloc<QuickSettleEvent, QuickSettleState> {
  QuickSettleBloc()
      : super(
          const QuickSettleState.initial(
            store: QuickSettleStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<QuickSettleState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const QuickSettleEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
