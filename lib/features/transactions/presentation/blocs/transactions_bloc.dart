import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'transactions_bloc.freezed.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';

@injectable
final class TransactionsBloc
    extends BaseBloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc()
      : super(
          const TransactionsState.initial(
            store: TransactionsStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<TransactionsState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const TransactionsEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
