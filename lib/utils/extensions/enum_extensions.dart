import 'package:recase/recase.dart';
import 'package:splittr/utils/extensions/list_extensions.dart';

extension EnumIterableX<E extends Enum> on Iterable<E> {
  E? fromString(String? enumString) {
    return firstWhereOrNull(
      (element) => element.name.constantCase == enumString?.constantCase,
    );
  }
}
