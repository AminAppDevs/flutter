import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/category/domain/entities/category.dart';
import 'package:jdolh_flutter/core/utils/image_placeholder.dart';

class CategoryModel extends Category {
  const CategoryModel(super.id, super.name, super.icon, super.banner, super.subCategories);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        json['id'],
        json['name'],
        ImageModel.fromJson(json['icon'] ?? ImagePlaceholder.categoryIcon),
        ImageModel.fromJson(json['banner'] ?? ImagePlaceholder.storeCover),
        (json['subCategories'] as List).map((category) => CategoryModel.fromJson(category)).toList(),
      );
}
