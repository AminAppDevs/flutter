import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(super.id, super.fullName, super.phoneNumber, super.avatar);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json['id'],
        json['fullName'],
        json['phoneNumber'],
        ImageModel.fromJson(json['avatar'] ??
            {
              "id": 0,
              "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
              "imageKey": "abdullah altamimi Cropped.jpg1669749178213"
            }),
      );
}
