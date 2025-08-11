part of 'quick_settle_bloc.dart';

@freezed
sealed class QuickSettleState extends BaseState with _$QuickSettleState {
  const QuickSettleState._();

  const factory QuickSettleState.initial({
    required QuickSettleStateStore store,
  }) = Initial;

  const factory QuickSettleState.changeLoaderState({
    required QuickSettleStateStore store,
  }) = ChangeLoaderState;

  const factory QuickSettleState.onFailure({
    required QuickSettleStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(Failure failure) => QuickSettleState.onFailure(
    store: store.copyWith(loading: false),
    failure: failure,
  );

  @override
  BaseState getLoaderState({required bool loading}) =>
      QuickSettleState.changeLoaderState(
        store: store.copyWith(loading: loading),
      );
}

@freezed
class QuickSettleStateStore with _$QuickSettleStateStore {
  const QuickSettleStateStore({
    this.loading = false,
    this.peopleRecord = const [],
    this.total = 0.0,
    this.individualShare = 0.0,
    this.individualShareList = const [],
    this.finalTransaction = const [],
    this.summaryMap = const {},
    this.tags = const [],
    this.toggleCard = true,
  });

  @override
  final bool loading;
  @override
  final List<({String name, double amount})> peopleRecord;
  @override
  final double total;
  @override
  final double individualShare;
  @override
  final List<double> individualShareList;
  @override
  final List<Map<String, String>> finalTransaction;
  @override
  final Map<String, List<Map<String, double>>> summaryMap;
  @override
  final List<SplitTransaction> tags;
  @override
  final bool toggleCard;
}
