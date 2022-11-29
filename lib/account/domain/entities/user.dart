import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/user_details.dart';

class User extends Equatable {
  final int id;
  final String fullName;
  final String phoneNumber;
  final Image avatar;

  const User(this.id, this.fullName, this.phoneNumber, this.avatar);
  @override
  List<Object?> get props => [id, fullName, phoneNumber, avatar];
}
