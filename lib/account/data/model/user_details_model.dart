import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/account/data/model/user_details_count_model.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  const UserDetailsModel(super.id, super.fullName, super.phoneNumber, super.count, super.avatar);

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        json['id'],
        json['fullName'],
        json['phoneNumber'],
        UserDetailsCountModel.fromJson(json['_count']),
        ImageModel.fromJson(json['avatar']),
      );
}
