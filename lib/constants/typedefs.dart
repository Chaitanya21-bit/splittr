import 'package:fpdart/fpdart.dart';

import '../dataclass/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;