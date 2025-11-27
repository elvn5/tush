// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/auth/data/datasources/auth_remote_data_source.dart' as _i767;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/sign_in_use_case.dart' as _i558;
import 'features/auth/domain/usecases/sign_up_use_case.dart' as _i477;
import 'features/auth/presentation/bloc/sign_in_bloc.dart' as _i457;
import 'features/auth/presentation/bloc/sign_up_bloc.dart' as _i572;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i767.AuthRemoteDataSource>(
      () => _i767.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i1015.AuthRepository>(
      () => _i111.AuthRepositoryImpl(gh<_i767.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i558.SignInUseCase>(
      () => _i558.SignInUseCase(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i477.SignUpUseCase>(
      () => _i477.SignUpUseCase(gh<_i1015.AuthRepository>()),
    );
    gh.factory<_i572.SignUpBloc>(
      () => _i572.SignUpBloc(gh<_i477.SignUpUseCase>()),
    );
    gh.factory<_i457.SignInBloc>(
      () => _i457.SignInBloc(gh<_i558.SignInUseCase>()),
    );
    return this;
  }
}
