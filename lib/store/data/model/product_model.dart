import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/store/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(super.id, super.name, super.description, super.images, super.type, super.regularPrice, super.salePrice, super.hasDiscount);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        json['id'],
        json['name'],
        json['description'],
        (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
        json['type'],
        json['regularPrice'] == null ? 0 : json['regularPrice'].toDouble(),
        json['salePrice'] == null ? 0 : json['salePrice'].toDouble(),
        json['hasDiscount'],
      );
}
