import 'package:equatable/equatable.dart';

class UserExist extends Equatable {
  final bool isExist;
  final String message;
  const UserExist(this.isExist, this.message);

  @override
  List<Object?> get props => [isExist, message];
}
