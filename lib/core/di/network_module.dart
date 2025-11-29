import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tush/core/network/auth_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {
    final dio = Dio();
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(PrettyDioLogger());
    return dio;
  }
}
