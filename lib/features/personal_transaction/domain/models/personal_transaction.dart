import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splittr/features/personal_transaction/data/dtos/personal_transaction_dto.dart';

part 'personal_transaction.freezed.dart';

@freezed
class PersonalTransaction with _$PersonalTransaction {
  const factory PersonalTransaction({
    String? transactionId,
    String? userId,
    String? title,
    double? amount,
    String? note,
    String? category, // TODO(Saurabh): Add enum
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PersonalTransaction;

  const PersonalTransaction._();

  factory PersonalTransaction.fromDto(PersonalTransactionDto dto) {
    return PersonalTransaction(
      transactionId: dto.transactionId,
      userId: dto.userId,
      title: dto.title,
      amount: dto.amount,
      note: dto.note,
      category: dto.category,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  PersonalTransactionDto toDto() {
    return PersonalTransactionDto(
      transactionId: transactionId,
      userId: userId,
      title: title,
      amount: amount,
      note: note,
      category: category,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
