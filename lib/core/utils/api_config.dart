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
  static const String isFollowExist = '/user/follow/is_exist';
  static const String getUserFollower = '/user/followers';
  static const String getUserFollowing = '/user/following';
  static const String syncUserPhoneContacts = '/user/phone_contact/sync';

  ///// account /////
  static const String getParentCategories = '/store/store_category/all';
  static const String getSubCategories = '/store/store_category/subcategories';
  static const String getStoresOfCategories = '/store/stores_of_category';
  static const String getStoreCategorySlides = '/store/stores_of_category/slides/all';

  ///// store /////
  static const String getStoreDetails = '/store/details';

  ///// product /////
  static const String getStoreProductCategories = '/products/product_category/store_categories';
  static const String getStoreProductDetails = '/products/store_product';

  ///// booking /////
  static const String getBranchReservationDays = '/store_branches/get_days';
}
