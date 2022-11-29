import 'package:jdolh_flutter/account/domain/entities/image.dart';

class ImageModel extends AppImage {
  const ImageModel(super.id, super.imageUrl, super.imageKey);

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        json['id'],
        json['imageUrl'],
        json['imageKey'],
      );
}
