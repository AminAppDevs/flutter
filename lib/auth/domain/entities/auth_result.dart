import 'package:equatable/equatable.dart';

class AuthResult extends Equatable {
  final int userId;
  final String token;

  const AuthResult(this.userId, this.token);
  @override
  List<Object?> get props => [userId, token];
}
