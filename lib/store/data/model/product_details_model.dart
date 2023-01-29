import 'package:jdolh_flutter/account/data/model/image_model.dart';
import 'package:jdolh_flutter/store/domain/entities/product_details.dart';

///// product details model
class ProductDetailsModel extends ProductDetails {
  const ProductDetailsModel(
      super.id, super.name, super.description, super.images, super.options, super.type, super.regularPrice, super.salePrice, super.hasDiscount);

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        json['id'],
        json['name'],
        json['description'],
        (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
        (json['options'] as List).map((e) => ProductOptionModel.fromJson(e)).toList(),
        json['type'],
        json['regularPrice'] == null ? 0 : json['regularPrice'].toDouble(),
        json['salePrice'] == null ? 0 : json['salePrice'].toDouble(),
        json['hasDiscount'],
      );
}

///// product option model
class ProductOptionModel extends ProductOption {
  const ProductOptionModel(super.id, super.title, super.optionType, super.optionItems);

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) => ProductOptionModel(
        json['id'],
        json['title'],
        OptionType.values.byName(json['optionType']),
        (json['optionItems'] as List).map((e) => ProductOptionItemModel.fromJson(e)).toList(),
      );
}

///// product option item
class ProductOptionItemModel extends ProductOptionItem {
  const ProductOptionItemModel(super.id, super.name, super.price);

  factory ProductOptionItemModel.fromJson(Map<String, dynamic> json) => ProductOptionItemModel(
        json['id'],
        json['name'],
        json['price'].toDouble(),
      );
}
