import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

class UserDetails extends Equatable {
  final int id;
  final String fullName;
  final String phoneNumber;
  final UserDetailsCount count;
  final AppImage avatar;

  const UserDetails(this.id, this.fullName, this.phoneNumber, this.count, this.avatar);
  @override
  List<Object?> get props => [id, fullName, phoneNumber, count, avatar];
}

///// count
class UserDetailsCount extends Equatable {
  final int followers;
  final int following;
  final int groups;

  const UserDetailsCount(this.followers, this.following, this.groups);
  @override
  List<Object?> get props => [followers, following, groups];
}
