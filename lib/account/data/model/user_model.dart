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
              "imageUrl": "https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/abdullah altamimi Cropped.jpg1669749178213",
              "imageKey": "abdullah altamimi Cropped.jpg1669749178213"
            }),
      );
}
