part of 'transactions_bloc.dart';

@freezed
class TransactionsEvent extends BaseEvent with _$TransactionsEvent {
  const factory TransactionsEvent.started() = _Started;
}
