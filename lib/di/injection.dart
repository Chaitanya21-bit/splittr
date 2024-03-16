import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/constants/env.dart';
import 'package:splittr/di/injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies(Env env) => getIt.init(environment: env.name);
