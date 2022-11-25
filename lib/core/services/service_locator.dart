import 'package:get_it/get_it.dart';
import 'package:jdolh_flutter/auth/data/datasource/local_auth_datasource.dart';
import 'package:jdolh_flutter/auth/data/datasource/remote_auth_datasource.dart';
import 'package:jdolh_flutter/auth/data/repository/auth_repository.dart';
import 'package:jdolh_flutter/auth/domain/repository/base_auth_repository.dart';
import 'package:jdolh_flutter/auth/domain/usecases/local_auth_usecases.dart';
import 'package:jdolh_flutter/auth/domain/usecases/login_usecase.dart';
import 'package:jdolh_flutter/auth/domain/usecases/register_usecase.dart';
import 'package:jdolh_flutter/auth/domain/usecases/user_exist_usecase.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    /// auth
    sl.registerLazySingleton<BaseRemoteAuthDatasource>(() => RemoteAuthDatasource());
    sl.registerLazySingleton<BaseLocalAuthDatasource>(() => LocalAuthDatasource());
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl(), sl()));
    sl.registerLazySingleton(() => LoginUsecase(sl()));
    sl.registerLazySingleton(() => RegisterUsecase(sl()));
    sl.registerLazySingleton(() => UserExistUsecase(sl()));
    sl.registerLazySingleton(() => LocalAuthUsecases(sl()));
  }
}
