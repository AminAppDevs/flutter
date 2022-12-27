import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/category/data/model/store_rating_summary_model.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';

class StoreModel extends Store {
  const StoreModel(super.id, super.name, super.bio, super.isActive, super.avatar, super.cover, super.rating);

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        json['id'],
        json['name'],
        json['bio'],
        json['isActive'],
        ImageModel.fromJson(
          json['avatar'] ??
              {
                "id": 0,
                "imageUrl": "https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083",
                "imageKey": "dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083"
              },
        ),
        ImageModel.fromJson(
          json['cover'] ??
              {
                "id": 0,
                "imageUrl": "https://jdolh-app-avatar.s3.ap-south-1.amazonaws.com/dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083",
                "imageKey": "dcb867df-6f58-46ec-a06b-214aad8a0bda__1671938129083"
              },
        ),
        (json['rating'] as List).map((e) => StoreRatingSummaryModel.fromJson(e)).toList(),
      );
}
