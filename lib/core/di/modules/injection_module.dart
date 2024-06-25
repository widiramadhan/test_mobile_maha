import 'package:test_it_maha/core/service/network_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModules {
  @lazySingleton
  NetworkService get client => NetworkService();
}
