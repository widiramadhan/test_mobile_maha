// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:test_it_maha/core/di/modules/injection_module.dart' as _i7;
import 'package:test_it_maha/core/service/network_service.dart' as _i3;
import 'package:test_it_maha/data/data_source/users_remote/users_remote.dart'
    as _i4;
import 'package:test_it_maha/data/repository/users_repository.dart' as _i5;
import 'package:test_it_maha/domain/usecase/users_usecase.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModules = _$InjectionModules();
    gh.lazySingleton<_i3.NetworkService>(() => injectionModules.client);
    gh.lazySingleton<_i4.UsersRemote>(
        () => _i4.UsersRemote(gh<_i3.NetworkService>()));
    gh.lazySingleton<_i5.UsersRepository>(
        () => _i5.UsersRepository(gh<_i4.UsersRemote>()));
    gh.lazySingleton<_i6.UsersUseCase>(
        () => _i6.UsersUseCase(gh<_i5.UsersRepository>()));
    return this;
  }
}

class _$InjectionModules extends _i7.InjectionModules {}
