import 'package:test_it_maha/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final inject = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async => inject.init();
