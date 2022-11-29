import 'package:equatable/equatable.dart';

class Success extends Equatable {
  final bool status;
  final String message;

  const Success(this.status, this.message);

  @override
  List<Object?> get props => [status, message];
}
