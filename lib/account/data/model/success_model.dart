import 'package:jdolh_flutter/account/domain/entities/success.dart';

class SuccessModel extends Success {
  const SuccessModel(super.status, super.message);

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        json['status'],
        json['message'],
      );
}
