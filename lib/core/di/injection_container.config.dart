// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../../domain/usecases/auth/get_current_user_usecase.dart' as _i6;
import '../../domain/usecases/auth/login_usecase.dart' as _i7;
import '../../domain/usecases/auth/logout_usecase.dart' as _i8;
import '../../presentation/bloc/auth/auth_bloc.dart' as _i9;
import 'injection_container.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.Dio>(registerModule.dio());
    await gh.singletonAsync<_i4.Box>(
      registerModule.settingsBox,
      instanceName: 'settingsBox',
      preResolve: true,
    );
    await gh.singletonAsync<_i4.Box>(
      registerModule.userBox,
      instanceName: 'userBox',
      preResolve: true,
    );
    await gh.singletonAsync<_i4.Box>(
      registerModule.gameBox,
      instanceName: 'gameBox',
      preResolve: true,
    );
    await gh.singletonAsync<_i5.SharedPreferences>(
      registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i6.GetCurrentUserUseCase>(() => _i6.GetCurrentUserUseCase());
    gh.factory<_i7.LoginUseCase>(() => _i7.LoginUseCase());
    gh.factory<_i8.LogoutUseCase>(() => _i8.LogoutUseCase());
    gh.factory<_i9.AuthBloc>(() => _i9.AuthBloc(
          gh<_i7.LoginUseCase>(),
          gh<_i8.LogoutUseCase>(),
          gh<_i6.GetCurrentUserUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}