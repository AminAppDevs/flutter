import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
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
  bool isFollowersFollowingLoading = false;
  UserDetails? userDetails;
  List<User> followers = [];
  List<User> following = [];
  List<User> followersSearchResult = [];
  List<User> followingsSearchResult = [];

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

  ///// update avatar

  ///// get user followers
  getUserFollowers() async {
    isFollowersFollowingLoading = true;
    update();
    Either<Failure, List<User>> result = await getUserFollowersUsecase(userId);
    result.fold(
      (Failure failure) {
        isFollowersFollowingLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (List<User> followers) {
        isFollowersFollowingLoading = false;
        this.followers = followers;
        followersSearchResult = followers;
        update();
      },
    );
  }

  ///// get user following
  getUserFollowing() async {
    Either<Failure, List<User>> result = await getUserFollowingUsecase(userId);
    result.fold(
      (Failure failure) {
        isFollowersFollowingLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (List<User> following) {
        isFollowersFollowingLoading = false;
        this.following = following;
        followingsSearchResult = following;
        update();
      },
    );
  }

  ///// search in followers and following
  searchFollowersFollowing(String term, bool isFollowers) {
    if (isFollowers) {
      if (term == '') {
        followersSearchResult = followers;
        update();
      } else {
        followersSearchResult = followers.where((User item) {
          return item.fullName.contains(term) || item.phoneNumber.contains(term);
        }).toList();
        update();
      }
    } else {
      if (term == '') {
        followingsSearchResult = following;
        update();
      } else {
        followingsSearchResult = following.where((User item) {
          return item.fullName.contains(term) || item.phoneNumber.contains(term);
        }).toList();
        update();
      }
    }
  }
}
