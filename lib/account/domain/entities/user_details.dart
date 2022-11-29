import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final int id;
  final String fullName;
  final String phoneNumber;
  final UserDetailsCount count;
  final Image avatar;

  const UserDetails(this.id, this.fullName, this.phoneNumber, this.count, this.avatar);
  @override
  List<Object?> get props => [id, fullName, phoneNumber, count, Image];
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

///// avatar
class Image extends Equatable {
  final int id;
  final String imageUrl;
  final String imageKey;

  const Image(this.id, this.imageUrl, this.imageKey);

  @override
  List<Object?> get props => [id, imageUrl, imageKey];
}
