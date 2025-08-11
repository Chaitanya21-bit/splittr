import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splittr/features/personal_transaction/data/dtos/personal_transaction_dto.dart';

part 'personal_transaction.freezed.dart';

@freezed
class PersonalTransaction with _$PersonalTransaction {
  const PersonalTransaction({
    this.transactionId,
    this.userId,
    this.title,
    this.amount,
    this.note,
    this.category, // TODO(Saurabh): Add enum
    this.createdAt,
    this.updatedAt,
  });

  @override
  final double? amount;

  @override
  final String? category;

  @override
  final DateTime? createdAt;

  @override
  final String? note;

  @override
  final String? title;

  @override
  final String? transactionId;

  @override
  final DateTime? updatedAt;

  @override
  final String? userId;

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
