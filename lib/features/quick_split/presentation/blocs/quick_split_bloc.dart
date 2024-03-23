import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'quick_split_bloc.freezed.dart';

part 'quick_split_event.dart';

part 'quick_split_state.dart';

@injectable
final class QuickSplitBloc extends BaseBloc<QuickSplitEvent, QuickSplitState> {
  QuickSplitBloc()
      : super(
          const QuickSplitState.initial(
            store: QuickSplitStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<QuickSplitState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const QuickSplitEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
