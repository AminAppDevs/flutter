import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';
import 'package:jdolh_flutter/account/domain/usecases/account_usecases.dart';
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';

class AccountController extends GetxController {
  ///// usecases
  final GetUserDetailsUsecase getUserDetailsUsecase;
  final UpdateUserAvatarUsecase updateUserAvatarUsecase;
  final MakeFollowUnfollowUsecase makeFollowUnfollowUsecase;
  final GetUserFollowersUsecase getUserFollowersUsecase;
  final GetUserFollowingUsecase getUserFollowingUsecase;
  final SyncUserPhoneContactsUsecase syncUserPhoneContactsUsecase;
  final GetUserGroupsUsecase getUserGroupsUsecase;
  final CreateGroupUsecase createGroupUsecase;
  final UpdateGroupUsecase updateGroupUsecase;
  final AddUserToGroupUsecase addUserToGroupUsecase;
  final RemoveUserFromGroupUsecase removeUserFromGroupUsecase;
  final DeleteGroupUsecase deleteGroupUsecase;

  AccountController(
    this.getUserDetailsUsecase,
    this.updateUserAvatarUsecase,
    this.makeFollowUnfollowUsecase,
    this.getUserFollowersUsecase,
    this.getUserFollowingUsecase,
    this.syncUserPhoneContactsUsecase,
    this.getUserGroupsUsecase,
    this.createGroupUsecase,
    this.updateGroupUsecase,
    this.addUserToGroupUsecase,
    this.removeUserFromGroupUsecase,
    this.deleteGroupUsecase,
  );

  final int userId = AuthController(sl(), sl(), sl(), sl()).localAuthUsecases.readUserId();

  @override
  void onInit() {
    super.onInit();

    getUserDetails();
  }

  ///// properites
  bool isUserDetailsLoading = false;
  UserDetails? userDetails;

  ///// methods
  ///get user details
  getUserDetails() async {
    Either<Failure, UserDetails> result = await getUserDetailsUsecase(userId);
    isUserDetailsLoading = true;
    update();
    result.fold(
      (Failure failure) {
        isUserDetailsLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (UserDetails userDetails) {
        isUserDetailsLoading = false;
        update();
        this.userDetails = userDetails;
        update();
        print(userDetails);
      },
    );
  }
}
