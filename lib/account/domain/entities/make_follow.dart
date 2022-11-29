import 'package:equatable/equatable.dart';

class MakeFollow extends Equatable {
  final bool status;
  final String message;

  const MakeFollow(this.status, this.message);
  @override
  List<Object?> get props => [];
}
