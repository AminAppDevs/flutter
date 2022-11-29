import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/user.dart';

class Group extends Equatable {
  final int id;
  final String name;
  final String createdAt;
  final List<User> members;

  const Group(this.id, this.name, this.createdAt, this.members);

  @override
  List<Object?> get props => [id, name, createdAt, members];
}
