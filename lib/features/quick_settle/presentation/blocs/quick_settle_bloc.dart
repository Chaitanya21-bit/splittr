import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/features/quick_settle/dataclass/split_transaction.dart';

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
    on<_CalculateTransactions>(_onCalculateTransactions);
  }

  void _onStarted(_Started event, Emitter<QuickSettleState> emit) {
    final people = List<({double amount, String name})>.from(event.peopleRecord)
      ..sort((a, b) => a.amount.compareTo(b.amount));

    double total = 0;
    for (final person in people) {
      total += person.amount;
    }
    final double individualShare = total / people.length;

    final List<double> individualShareList = List<double>.generate(
      people.length,
      (index) => people[index].amount - individualShare,
    );

    emit(
      QuickSettleState.initial(
        store: state.store.copyWith(
          peopleRecord: people,
          total: total,
          individualShare: individualShare,
          individualShareList: individualShareList,
        ),
      ),
    );

    add(const QuickSettleEvent.calculateTransactions());
  }

  void _onCalculateTransactions(
    _CalculateTransactions event,
    Emitter<QuickSettleState> emit,
  ) {
    final people = state.store.peopleRecord;
    final List<double> individualShareList =
        List.from(state.store.individualShareList);
    final List<Map<String, String>> finalTransaction = [];
    final List<SplitTransaction> tags = [];

    int i = 0;
    int j = people.length - 1;

    while (i < j) {
      final double sum = individualShareList[i] + individualShareList[j];
      if (sum > 0) {
        finalTransaction.add(
          {people[i].name: '${people[j].name}|${individualShareList[i]}'},
        );

        tags.add(
          SplitTransaction(
            people[i].name,
            people[j].name,
            individualShareList[i],
          ),
        );
        individualShareList[i] = 0;
        individualShareList[j] = sum;
        i++;
      } else if (sum < 0) {
        finalTransaction.add(
          {people[i].name: '${people[j].name}|-${individualShareList[j]}'},
        );

        tags.add(
          SplitTransaction(
            people[i].name,
            people[j].name,
            -individualShareList[j],
          ),
        );
        individualShareList[j] = 0;
        individualShareList[i] = sum;
        j--;
      } else {
        finalTransaction.add(
          {people[i].name: '${people[j].name}|${individualShareList[i]}'},
        );

        tags.add(
          SplitTransaction(
            people[i].name,
            people[j].name,
            individualShareList[i],
          ),
        );
        individualShareList[j] = 0;
        individualShareList[i] = 0;
        i++;
        j--;
      }
    }

    emit(
      QuickSettleState.initial(
        store: state.store.copyWith(
          finalTransaction: finalTransaction,
          tags: tags,
        ),
      ),
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    final peopleRecords = args?[StringConstants.peopleRecords];
    add(QuickSettleEvent.started(peopleRecord: peopleRecords));
  }

  @override
  bool get isLoading => state.store.loading;
}
