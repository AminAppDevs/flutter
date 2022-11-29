import 'package:jdolh_flutter/account/data/model/user_model.dart';
import 'package:jdolh_flutter/account/domain/entities/group.dart';

class GroupModel extends Group {
  const GroupModel(super.id, super.name, super.createdAt, super.members);

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        json['id'],
        json['name'],
        json['createdAt'],
        List.from(json['members']).map((e) => UserModel.fromJson(e)).toList(),
      );
}
