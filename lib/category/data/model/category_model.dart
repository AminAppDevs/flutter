import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel(super.id, super.name, super.icon, super.banner);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        json['id'],
        json['name'],
        ImageModel.fromJson(
          json['icon'] ??
              {
                "id": 0,
                "imageUrl": "https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/539896de-572b-4fe0-9123-37a618b0a344__1671938065165",
                "imageKey": "539896de-572b-4fe0-9123-37a618b0a344__1671938065165"
              },
        ),
        ImageModel.fromJson(
          json['banner'] ??
              {
                "id": 0,
                "imageUrl": "https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083",
                "imageKey": "dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083"
              },
        ),
      );
}
