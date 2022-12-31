import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/category/data/model/store_rating_summary_model.dart';
import 'package:jdolh_flutter/core/utils/image_placeholder.dart';
import 'package:jdolh_flutter/store/data/model/store_branch_model.dart';
import 'package:jdolh_flutter/store/domain/entities/store_details.dart';

class StoreDetailsModel extends StoreDetails {
  StoreDetailsModel(super.id, super.name, super.bio, super.isActive, super.avatar, super.cover, super.branches, super.rating);
  factory StoreDetailsModel.fromJson(Map<String, dynamic> json) => StoreDetailsModel(
        json['id'],
        json['name'],
        json['bio'],
        json['isActive'],
        ImageModel.fromJson(json['avatar'] ?? ImagePlaceholder.storeAvatar),
        ImageModel.fromJson(json['cover'] ?? ImagePlaceholder.storeCover),
        (json['branches'] as List).map((e) => StoreBranchModel.fromJson(e)).toList(),
        (json['rating'] as List).map((e) => StoreRatingSummaryModel.fromJson(e)).toList(),
      );
}
