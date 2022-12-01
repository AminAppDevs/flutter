import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_flutter/account/domain/entities/group.dart';
import 'package:jdolh_flutter/account/domain/entities/success.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';
import 'package:jdolh_flutter/account/domain/usecases/account_usecases.dart';
import 'package:jdolh_flutter/account/presentation/screens/group_details_screen.dart';
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
  bool isUploadAvatarLoading = false;
  bool isUserGroupsLoading = false;
  bool isCreateGroupLoading = false;
  UserDetails? userDetails;
  List<User> followers = [];
  List<User> following = [];
  List<User> followersSearchResult = [];
  List<User> followingsSearchResult = [];
  bool isSearchActive = false;
  XFile? imagePicked;
  List<Group> groups = [];
  Group? group;

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
  updateUserAvatar() async {
    isUploadAvatarLoading = true;
    update();
    final Either<Failure, Success> result = await updateUserAvatarUsecase(imagePicked!, userId);
    result.fold(
      (Failure failure) {
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
        isUploadAvatarLoading = false;
        update();
      },
      (Success success) {
        isUploadAvatarLoading = false;
        update();
        Get.back();
        imagePicked = null;
        update();
        getUserDetails();
      },
    );
  }

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

  changeSearchActiveStatus() {
    isSearchActive = !isSearchActive;
    update();
  }

  ///// pick image
  pickImage(bool isGallery) async {
    final ImagePicker picker = ImagePicker();
    if (isGallery) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 8);
      imagePicked = image;
      update();
      print(image!.path);
    } else {
      final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 8);
      imagePicked = image;
      update();
      print(image);
    }
  }

  ///// get user groups
  getUserGroups() async {
    isUserGroupsLoading = true;
    update();
    Either<Failure, List<Group>> result = await getUserGroupsUsecase(userId);
    result.fold(
      (Failure failure) {
        isUserGroupsLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (List<Group> groups) {
        isUserGroupsLoading = false;
        this.groups = groups;
        update();
        print(this.groups);
        print(groups);
      },
    );
  }

///// create group
  createGroup(String name) async {
    isCreateGroupLoading = true;
    update();
    Either<Failure, Group> result = await createGroupUsecase(userId, name);
    result.fold(
      (Failure failure) {
        isCreateGroupLoading = false;
        update();
        print(failure);
        if (failure.statusCode == 409) {
          AppSnackbar.errorSnackbar(message: 'توجد مجموعة بنفس الإسم، الرجاء اختيار اسم اخر');
        } else {
          AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
        }
      },
      (Group group) {
        isCreateGroupLoading = false;
        update();
        getUserGroups();
        Get.back();
        getGroupDetails(group);
      },
    );
  }

  ///// get group details
  getGroupDetails(Group group) {
    this.group = group;
    update();
    Get.to(() => GroupDetailsScreen());
  }

  ///// remove member from group
  removeMemberFromGroup(int groupId, int memberId) async {
    Either<Failure, Group> result = await removeUserFromGroupUsecase(groupId, memberId);
    result.fold(
      (Failure failure) {
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (Group group) {
        getGroupDetails(group);
      },
    );
  }
}
