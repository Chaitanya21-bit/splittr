part of 'personal_transaction_bloc.dart';

@freezed
class PersonalTransactionEvent extends BaseEvent
    with _$PersonalTransactionEvent {
  const factory PersonalTransactionEvent.started() = _Started;
}
