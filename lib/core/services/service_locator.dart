import 'package:get_it/get_it.dart';
import 'package:jdolh_flutter/account/data/datasource/base_remote_account_datasource.dart';
import 'package:jdolh_flutter/account/data/datasource/remote_account_datasource.dart';
import 'package:jdolh_flutter/account/data/repository/account_repository.dart';
import 'package:jdolh_flutter/account/domain/repository/base_account_repository.dart';
import 'package:jdolh_flutter/account/domain/usecases/account_usecases.dart';
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

    /// account
    sl.registerLazySingleton<BaseRemoteAccountDataSource>(() => RemoteAccountDatasource());
    sl.registerLazySingleton<BaseAccountRepository>(() => AccountRepository(sl()));
    sl.registerLazySingleton(() => GetUserDetailsUsecase(sl()));
    sl.registerLazySingleton(() => UpdateUserAvatarUsecase(sl()));
    sl.registerLazySingleton(() => MakeFollowUnfollowUsecase(sl()));
    sl.registerLazySingleton(() => GetUserFollowersUsecase(sl()));
    sl.registerLazySingleton(() => GetUserFollowingUsecase(sl()));
    sl.registerLazySingleton(() => SyncUserPhoneContactsUsecase(sl()));
    sl.registerLazySingleton(() => GetUserGroupsUsecase(sl()));
    sl.registerLazySingleton(() => updateGroupUsecase(sl()));
    sl.registerLazySingleton(() => AddUserToGroupUsecase(sl()));
    sl.registerLazySingleton(() => RemoveUserFromGroupUsecase(sl()));
    sl.registerLazySingleton(() => DeleteGroupUsecase(sl()));
    sl.registerLazySingleton(() => CreateGroupUsecase(sl()));
  }
}
