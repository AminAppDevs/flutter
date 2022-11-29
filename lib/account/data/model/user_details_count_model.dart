import 'package:jdolh_flutter/account/domain/entities/user_details.dart';

class UserDetailsCountModel extends UserDetailsCount {
  const UserDetailsCountModel(super.followers, super.following, super.groups);

  factory UserDetailsCountModel.fromJson(Map<String, dynamic> json) => UserDetailsCountModel(
        json['followers'],
        json['following'],
        json['groups'],
      );
}
