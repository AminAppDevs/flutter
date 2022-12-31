import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/category/domain/entities/category_slide.dart';

class CategorySlideModel extends CategorySlide {
  const CategorySlideModel(super.id, super.storeId, super.image);

  factory CategorySlideModel.fromJson(Map<String, dynamic> json) => CategorySlideModel(
        json['id'],
        json['storeId'],
        ImageModel.fromJson(
          json['image'] ??
              {
                "id": 0,
                "imageUrl": "https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083",
                "imageKey": "dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083"
              },
        ),
      );
}
