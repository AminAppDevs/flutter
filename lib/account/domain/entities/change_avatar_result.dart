import 'package:equatable/equatable.dart';

class ChangeAvatarResult extends Equatable {
  final bool status;
  final String message;

  const ChangeAvatarResult(this.status, this.message);
  @override
  List<Object?> get props => [status, message];
}
