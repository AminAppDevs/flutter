class ApiConfig {
  static const String baseUrl = 'http://192.168.8.3:3000';
  ///// auth /////
  static const String userExist = '/auth/user';
  static const String login = '/auth/user/login';
  static const String register = '/auth/user/register';

  ///// account /////
  static const String userDetails = '/user/details';
  static const String updateUserAvatar = '/user/details/avatar';
  static const String getUserGroups = '/user/group/all';
  static const String createGroup = '/user/group/create';
  static const String updateGroup = '/user/group/update';
  static const String addUserToGroup = '/user/group/add_user';
  static const String removeUserFromGroup = '/user/group/remove_user';
  static const String deleteGroup = '/user/group/delete';
  static const String makeFollowUnfollow = '/user/follow/create';
  static const String getUserFollower = '/user/followers';
  static const String getUserFollowing = '/user/following';
  static const String syncUserPhoneContacts = '/user/phone_contact/sync';
}
