import 'package:jdolh_flutter/core/error/server_error_model.dart';

class ServerException implements Exception {
  final ServerErrorModel serverErrorModel;

  ServerException(this.serverErrorModel);
}
