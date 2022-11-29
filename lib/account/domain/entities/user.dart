import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

class User extends Equatable {
  final int id;
  final String fullName;
  final String phoneNumber;
  final AppImage avatar;

  const User(this.id, this.fullName, this.phoneNumber, this.avatar);
  @override
  List<Object?> get props => [id, fullName, phoneNumber, avatar];
}
