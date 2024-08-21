import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
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
    on<_AddPerson>(_onAddPerson);
    on<_DeletePerson>(_onDeletePerson);
    on<_NameChanged>(_onNameChanged);
    on<_AmountChanged>(_onAmountChanged);
    on<_QuickSettleClicked>(_onQuickSettleClicked);
  }

  void _onStarted(_Started event, Emitter<QuickSplitState> emit) {}

  void _onAddPerson(_AddPerson event, Emitter<QuickSplitState> emit) {
    final updatedPeople =
        List<({double amount, String name})>.from(state.store.peopleRecord)
          ..add((name: event.name, amount: event.amount));
    emit(
      QuickSplitState.addedPerson(
        store: state.store.copyWith(peopleRecord: updatedPeople),
      ),
    );
  }

  void _onDeletePerson(_DeletePerson event, Emitter<QuickSplitState> emit) {
    final updatedPeopleRecord =
        List<({double amount, String name})>.from(state.store.peopleRecord)
          ..removeAt(event.index);

    emit(
      QuickSplitState.deletedPerson(
        store: state.store.copyWith(peopleRecord: updatedPeopleRecord),
      ),
    );
  }

  void _onNameChanged(_NameChanged event, Emitter<QuickSplitState> emit) {
    final existingRecord = state.store.peopleRecord[event.index];
    final records =
        List<({double amount, String name})>.from(state.store.peopleRecord)
          ..replaceRange(
            event.index,
            event.index + 1,
            [(name: event.name, amount: existingRecord.amount)],
          );

    emit(
      QuickSplitState.nameChange(
        store: state.store.copyWith(
          peopleRecord: records,
        ),
      ),
    );
  }

  void _onAmountChanged(_AmountChanged event, Emitter<QuickSplitState> emit) {
    final existingRecord = state.store.peopleRecord[event.index];
    final records =
        List<({double amount, String name})>.from(state.store.peopleRecord)
          ..replaceRange(
            event.index,
            event.index + 1,
            [(name: existingRecord.name, amount: event.amount)],
          );

    emit(
      QuickSplitState.amountChange(
        store: state.store.copyWith(
          peopleRecord: records,
        ),
      ),
    );
  }

  void _onQuickSettleClicked(
    _QuickSettleClicked event,
    Emitter<QuickSplitState> emit,
  ) {
    emit(
      QuickSplitState.quickSettle(
        store: state.store.copyWith(
          peopleRecord: state.store.peopleRecord,
        ),
      ),
    );
  }

  void addPerson({required String name, required double amount}) {
    add(
      QuickSplitEvent.addPerson(name: name, amount: amount),
    );
  }

  void amountChanged({required int index, required double amount}) {
    add(
      QuickSplitEvent.amountChanged(index: index, amount: amount),
    );
  }

  void nameChanged({required int index, required String name}) {
    add(
      QuickSplitEvent.nameChanged(index: index, name: name),
    );
  }

  void deletePerson({required int index}) {
    add(
      QuickSplitEvent.deletePerson(index: index),
    );
  }

  void quickSettleClicked() {
    add(
      const QuickSplitEvent.quickSettleClicked(),
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const QuickSplitEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
