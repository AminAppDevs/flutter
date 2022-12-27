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
import 'package:jdolh_flutter/category/data/datasource/base_remote_category_datasource.dart';
import 'package:jdolh_flutter/category/data/datasource/remote_category_datasource.dart';
import 'package:jdolh_flutter/category/data/repository/category_repository.dart';
import 'package:jdolh_flutter/category/domain/repository/base_category_repository.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_parent_categories_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_stores_of_category_usecase.dart';
import 'package:jdolh_flutter/category/domain/usecases/get_subcategories_usecase.dart';

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
    sl.registerLazySingleton(() => UpdateUserInfoUsecase(sl()));
    sl.registerLazySingleton(() => UpdateUserAvatarUsecase(sl()));
    sl.registerLazySingleton(() => MakeFollowUnfollowUsecase(sl()));
    sl.registerLazySingleton(() => IsFollowExistUsecase(sl()));
    sl.registerLazySingleton(() => GetUserFollowersUsecase(sl()));
    sl.registerLazySingleton(() => GetUserFollowingUsecase(sl()));
    sl.registerLazySingleton(() => SyncUserPhoneContactsUsecase(sl()));
    sl.registerLazySingleton(() => GetUserGroupsUsecase(sl()));
    sl.registerLazySingleton(() => UpdateGroupUsecase(sl()));
    sl.registerLazySingleton(() => AddUserToGroupUsecase(sl()));
    sl.registerLazySingleton(() => RemoveUserFromGroupUsecase(sl()));
    sl.registerLazySingleton(() => DeleteGroupUsecase(sl()));
    sl.registerLazySingleton(() => CreateGroupUsecase(sl()));

    /// category
    sl.registerLazySingleton<BaseRemoteCategoryDatasource>(() => RemoteCategoryDatasource());
    sl.registerLazySingleton<BaseCategoryRepository>(() => CategoryRepository(sl()));
    sl.registerLazySingleton(() => GetParentCategoriesUsecase(sl()));
    sl.registerLazySingleton(() => GetSubCategoriesUsecase(sl()));
    sl.registerLazySingleton(() => GetStoresOfCategoryUsecase(sl()));
  }
}
