// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/di/network_module.dart' as _i177;
import 'core/network/auth_interceptor.dart' as _i8;
import 'core/presentation/bloc/theme_cubit.dart' as _i1050;
import 'features/auth/data/datasources/auth_remote_data_source.dart' as _i767;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/confirm_reset_password_use_case.dart'
    as _i820;
import 'features/auth/domain/usecases/confirm_sign_up_use_case.dart' as _i1006;
import 'features/auth/domain/usecases/reset_password_use_case.dart' as _i536;
import 'features/auth/domain/usecases/sign_in_use_case.dart' as _i558;
import 'features/auth/domain/usecases/sign_up_use_case.dart' as _i477;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/auth/presentation/bloc/forgot_password_bloc.dart' as _i1045;
import 'features/auth/presentation/bloc/profile_bloc.dart' as _i930;
import 'features/auth/presentation/bloc/reset_password_bloc.dart' as _i806;
import 'features/auth/presentation/bloc/sign_in_bloc.dart' as _i457;
import 'features/auth/presentation/bloc/sign_up_bloc.dart' as _i572;
import 'features/dreams/data/repositories/dreams_repository_impl.dart' as _i881;
import 'features/dreams/domain/repositories/dreams_repository.dart' as _i324;
import 'features/dreams/presentation/bloc/dreams_bloc.dart' as _i687;
import 'features/friends/data/repositories/friends_repository_impl.dart'
    as _i987;
import 'features/friends/domain/repositories/friends_repository.dart' as _i1042;
import 'features/friends/domain/usecases/add_friend_use_case.dart' as _i545;
import 'features/friends/domain/usecases/get_friends_use_case.dart' as _i195;
import 'features/friends/domain/usecases/remove_friend_use_case.dart' as _i878;
import 'features/friends/domain/usecases/search_users_use_case.dart' as _i738;
import 'features/friends/presentation/bloc/friends_bloc.dart' as _i707;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i8.AuthInterceptor>(() => _i8.AuthInterceptor());
    gh.factory<_i1050.ThemeCubit>(() => _i1050.ThemeCubit());
    gh.lazySingleton<_i363.AuthBloc>(() => _i363.AuthBloc());
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
    gh.factory<_i1006.ConfirmSignUpUseCase>(
      () => _i1006.ConfirmSignUpUseCase(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i8.AuthInterceptor>()),
    );
    gh.factory<_i457.SignInBloc>(
      () => _i457.SignInBloc(gh<_i558.SignInUseCase>(), gh<_i363.AuthBloc>()),
    );
    gh.lazySingleton<_i324.DreamsRepository>(
      () => _i881.DreamsRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1042.FriendsRepository>(
      () => _i987.FriendsRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i545.AddFriendUseCase>(
      () => _i545.AddFriendUseCase(gh<_i1042.FriendsRepository>()),
    );
    gh.lazySingleton<_i195.GetFriendsUseCase>(
      () => _i195.GetFriendsUseCase(gh<_i1042.FriendsRepository>()),
    );
    gh.lazySingleton<_i878.RemoveFriendUseCase>(
      () => _i878.RemoveFriendUseCase(gh<_i1042.FriendsRepository>()),
    );
    gh.lazySingleton<_i738.SearchUsersUseCase>(
      () => _i738.SearchUsersUseCase(gh<_i1042.FriendsRepository>()),
    );
    gh.factory<_i707.FriendsBloc>(
      () => _i707.FriendsBloc(
        gh<_i738.SearchUsersUseCase>(),
        gh<_i545.AddFriendUseCase>(),
        gh<_i195.GetFriendsUseCase>(),
        gh<_i878.RemoveFriendUseCase>(),
      ),
    );
    gh.factory<_i572.SignUpBloc>(
      () => _i572.SignUpBloc(
        gh<_i477.SignUpUseCase>(),
        gh<_i1006.ConfirmSignUpUseCase>(),
      ),
    );
    gh.lazySingleton<_i820.ConfirmResetPasswordUseCase>(
      () => _i820.ConfirmResetPasswordUseCase(gh<_i1015.AuthRepository>()),
    );
    gh.lazySingleton<_i536.ResetPasswordUseCase>(
      () => _i536.ResetPasswordUseCase(gh<_i1015.AuthRepository>()),
    );
    gh.factory<_i930.ProfileBloc>(
      () => _i930.ProfileBloc(gh<_i1015.AuthRepository>()),
    );
    gh.factory<_i687.DreamsBloc>(
      () => _i687.DreamsBloc(gh<_i324.DreamsRepository>()),
    );
    gh.factory<_i806.ResetPasswordBloc>(
      () => _i806.ResetPasswordBloc(gh<_i820.ConfirmResetPasswordUseCase>()),
    );
    gh.factory<_i1045.ForgotPasswordBloc>(
      () => _i1045.ForgotPasswordBloc(gh<_i536.ResetPasswordUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i177.NetworkModule {}
