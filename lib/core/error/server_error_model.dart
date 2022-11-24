import 'package:equatable/equatable.dart';

class ServerErrorModel extends Equatable {
  final int statusCode;
  final String message;

  const ServerErrorModel(this.statusCode, this.message);
  factory ServerErrorModel.fromJson(Map<String, dynamic> json) => ServerErrorModel(json['statusCode'], json['message'].toString());

  @override
  List<Object?> get props => [statusCode, message];
}
