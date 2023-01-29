import 'package:jdolh_flutter/store/data/model/product_model.dart';
import 'package:jdolh_flutter/store/domain/entities/product_category.dart';

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel(super.id, super.name, super.storeId, super.products);

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
        json['id'],
        json['name'],
        json['storeId'],
        (json['products'] as List).map((e) => ProductModel.fromJson(e)).toList(),
      );
}
