import 'dart:ffi';

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
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AccountController extends GetxController {
  ///// usecases
  final GetUserDetailsUsecase getUserDetailsUsecase;
  final UpdateUserInfoUsecase updateUserInfoUsecase;
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
  final IsFollowExistUsecase isFollowExistUsecase;

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
    this.updateUserInfoUsecase,
    this.isFollowExistUsecase,
  );

  final int userId = AuthController(sl(), sl(), sl(), sl()).localAuthUsecases.readUserId();

  @override
  void onInit() {
    super.onInit();

    getUserDetails();
    getUserFollowing();
  }

  ///// properites
  bool isUserDetailsLoading = false;
  bool isUserProfileDetailsLoading = false;
  bool isFollowersFollowingLoading = false;
  bool isUploadAvatarLoading = false;
  bool isUserGroupsLoading = false;
  bool isCreateGroupLoading = false;
  bool isGetContactsLoading = false;
  bool isMakeFollowLoading = false;
  bool isUpdateUserInfoLoading = false;
  bool isAddMemeberToGroupLoading = false;
  bool isExistFollowLoading = false;
  bool isUpdateGroupLoading = false;
  int loadingFlollowUserId = 0;
  bool isMakeUnfollowForFollowingLoading = false;
  bool isFriendsSearchActive = false;
  int followingIdisMakeUnfollowForFollowing = 0;
  UserDetails? userDetails;
  UserDetails? userProfileDetails;
  List<User> followers = [];
  List<User> following = [];
  List<User> followersSearchResult = [];
  List<User> followingsSearchResult = [];
  bool isSearchActive = false;
  XFile? imagePicked;
  List<Group> groups = [];
  Group? group;
  List<Map> contactsToInviteAll = [];
  List<Map> contactsToInvite = [];
  List<User> syncedUsers = [];
  String fullNameForUpdate = '';
  int groupIdToAddUser = 0;
  int userIdToAddToGroup = 0;
  List<User> memberToAddToGroup = [];
  bool isFollowingUserExist = false;
  String updateGroupNewName = '';

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
      },
    );
  }

  ///// get user profile details
  getUserProfileDetails(int userProfileId) async {
    Either<Failure, UserDetails> result = await getUserDetailsUsecase(userProfileId);
    isUserProfileDetailsLoading = true;
    update();
    isFollowExistMethod(userProfileId);
    result.fold(
      (Failure failure) {
        isUserProfileDetailsLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (UserDetails userDetails) {
        isUserProfileDetailsLoading = false;
        update();
        this.userProfileDetails = userDetails;
        update();
      },
    );
  }

  updateIsFriendsSearch() {
    isFriendsSearchActive = !isFriendsSearchActive;
    update();
  }

  ////// update user info
  updateUserInfo(Map<String, dynamic> body) async {
    isUpdateUserInfoLoading = true;
    update();
    Either<Failure, Success> result = await updateUserInfoUsecase(userId, body);
    result.fold(
      (Failure failure) {
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
        isUpdateUserInfoLoading = false;
        update();
      },
      (Success success) {
        getUserDetails();
        isUpdateUserInfoLoading = false;
        update();
        Get.back();
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
    isFollowersFollowingLoading = true;
    update();
    Either<Failure, List<User>> result = await getUserFollowingUsecase(userId);
    result.fold(
      (Failure failure) {
        isFollowersFollowingLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (List<User> following) {
        print(following);
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
    } else {
      final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 8);
      imagePicked = image;
      update();
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
        if (failure.statusCode == 409) {
          AppSnackbar.errorSnackbar(message: 'توجد لديك مجموعة بنفس الإسم، الرجاء اختيار اسم اخر');
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

  ////// update group
  updateGroup(int groupId) async {
    isUpdateGroupLoading = true;
    update();
    Either<Failure, Group> result = await updateGroupUsecase(groupId, updateGroupNewName);
    result.fold(
      (Failure failure) {
        isUpdateGroupLoading = false;
        update();
        if (failure.statusCode == 409) {
          AppSnackbar.errorSnackbar(message: 'توجد لديك مجموعة بنفس الإسم، الرجاء اختيار اسم اخر');
        } else {
          AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
        }
      },
      (Group group) {
        getUserGroups();
        this.group = group;
        isUpdateGroupLoading = false;
        update();
        Get.back();
      },
    );
  }

  ///// get group details
  getGroupDetails(Group group) {
    this.group = group;
    update();
    Get.to(() => GroupDetailsScreen());
  }

  ///// add user to group
  addUserToGroup(int memberId) async {
    isAddMemeberToGroupLoading = true;
    update();
    Either<Failure, Group> result = await addUserToGroupUsecase(groupIdToAddUser, memberId);
    result.fold(
      (Failure failure) {},
      (Group group) {
        getUserGroups();
        this.group = group;
        isAddMemeberToGroupLoading = false;
        update();
        Get.back();
      },
    );
  }

  ///// remove member from group
  removeMemberFromGroup(int groupId, int memberId) async {
    Either<Failure, Group> result = await removeUserFromGroupUsecase(groupId, memberId);
    result.fold(
      (Failure failure) {
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (Group group) {
        getUserGroups();
        this.group = group;
        update();
      },
    );
  }

  ///// 1- get contacts and filter them
  getContacts() async {
    isGetContactsLoading = true;
    update();

    PermissionStatus status = await Permission.contacts.status;

    if (status.isDenied) {
      PermissionStatus requestPermission = await Permission.contacts.request();
      if (requestPermission.isGranted) {
        getContactsMethod();
      }
    } else if (status.isGranted) {
      getContactsMethod();
    } else {}
  }

  ///// get contacts methods
  getContactsMethod() async {
    List<Contact> contacts = await ContactsService.getContacts(
      withThumbnails: false,
      photoHighResolution: false,
    );
    List<Contact> hasPhoneContacts = await contacts.where(((Contact contact) => contact.phones!.isNotEmpty)).toList();

    List<Map> contactsInfo = await hasPhoneContacts.map((Contact contact) {
      String phoneWithoutSpace = contact.phones!.first.value!.replaceAll(new RegExp(r'[^0-9]'), "");
      String notEmptyPhone = '';
      if (phoneWithoutSpace.length >= 9) {
        notEmptyPhone = phoneWithoutSpace.substring(phoneWithoutSpace.length - 9);
      }

      return {
        "name": contact.displayName,
        "fullPhone": contact.phones!.first.value,
        "phoneWithoutCode": '0$notEmptyPhone',
      };
    }).toList();

    //// get string list of phones
    List<String> phonesTosync = contactsInfo.map((Map e) => e['phoneWithoutCode'].toString()).toList();

    ///get sync phones to db
    syncPhoneContacts(phonesNumbers: phonesTosync, contactsInfo: contactsInfo);
    isGetContactsLoading = false;
    update();
  }

  ///// sync phone contacts
  syncPhoneContacts({required List<String> phonesNumbers, required List<Map> contactsInfo}) async {
    isGetContactsLoading = true;
    update();

    var result = await syncUserPhoneContactsUsecase(phonesNumbers);
    result.fold(
      (Failure failure) {
        isGetContactsLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (List<User> users) async {
        /// compare contacts info to users from server return just not in app contact
        List<Map> contactsNotInApp =
            contactsInfo.where((element) => !users.any((User user) => user.phoneNumber == element['phoneWithoutCode'])).toList();
        contactsToInvite = contactsNotInApp;
        contactsToInviteAll = contactsNotInApp;
        isGetContactsLoading = false;
        update();

        var filteredSyncedContacts = users.where((element) => !following.any((User user) => user.phoneNumber == element.phoneNumber)).toList();
        syncedUsers = filteredSyncedContacts;
        update();

        print(following);
      },
    );
  }

  ///// serch in contacts
  searchInContacts(String query) async {
    if (query == '') {
      contactsToInvite = contactsToInviteAll;
      update();
    } else {
      contactsToInvite = contactsToInvite.where((element) => element['name'].contains(query) || element['fullPhone'].contains(query)).toList();
      update();
    }
  }

  ////// make follow
  makeFollowOnFriendsScreen(int followingId) async {
    loadingFlollowUserId = followingId;
    isFollowersFollowingLoading = true;
    update();
    Either<Failure, Success> result = await makeFollowUnfollowUsecase(userId, followingId);
    result.fold(
      (Failure failure) {
        isFollowersFollowingLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (Success success) {
        isFollowersFollowingLoading = false;
        update();
        syncedUsers.removeWhere((element) => element.id == followingId);
        update();
        getUserDetails();
      },
    );
  }

  /// make follow on profile screen
  makeFollowOnProfilePage(int followingId) async {
    isExistFollowLoading = true;
    update();
    Either<Failure, Success> result = await makeFollowUnfollowUsecase(userId, followingId);
    result.fold(
      (Failure failure) {
        isExistFollowLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (Success success) {
        isExistFollowLoading = false;
        update();
        isFollowExistMethod(followingId);
        getUserDetails();
      },
    );
  }

  ////// is exist follow
  isFollowExistMethod(int followingId) async {
    isExistFollowLoading = true;
    update();
    Either<Failure, Success> result = await isFollowExistUsecase(userId, followingId);
    result.fold(
      (Failure failure) {
        isExistFollowLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (Success success) {
        isFollowingUserExist = success.status;
        update();
        isExistFollowLoading = false;
        update();
      },
    );
  }

  ////// make unfollow to following
  makeUnfollowTofollowing(int followingId) async {
    isMakeUnfollowForFollowingLoading = true;
    followingIdisMakeUnfollowForFollowing = followingId;
    update();
    Either<Failure, Success> result = await makeFollowUnfollowUsecase(userId, followingId);

    result.fold(
      (Failure failure) {
        isMakeUnfollowForFollowingLoading = false;
        update();
        AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      },
      (Success success) {
        isMakeUnfollowForFollowingLoading = false;
        update();
        getUserFollowing();
        getUserDetails();
      },
    );
  }

  ///// filter member to add to group
  filterMemberToAddToGroup() async {
    followingsSearchResult = following.where((follow) => !group!.members.any((member) => member.id == follow.id)).toList();
    update();
  }
}
