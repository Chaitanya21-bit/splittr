import 'package:recase/recase.dart';

extension EnumIterableX<E extends Enum?> on Iterable<E> {
  E? fromString(String? enumString) {
    try {
      return firstWhere(
        (element) =>
            element != null &&
            element.name.constantCase == enumString?.constantCase,
      );
    } catch (_) {
      return null;
    }
  }
}
