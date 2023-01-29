import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

///// product details
class ProductDetails extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<AppImage> images;
  final List<ProductOption> options;
  final String type;
  final double regularPrice;
  final double salePrice;
  final bool hasDiscount;
  const ProductDetails(
    this.id,
    this.name,
    this.description,
    this.images,
    this.options,
    this.type,
    this.regularPrice,
    this.salePrice,
    this.hasDiscount,
  );

  @override
  List<Object?> get props => [id, name, description, images, options];
}

///// product option
class ProductOption extends Equatable {
  final int id;
  final String title;
  final OptionType optionType;
  final List<ProductOptionItem> optionItems;
  const ProductOption(this.id, this.title, this.optionType, this.optionItems);

  @override
  List<Object?> get props => [id, title, optionType, optionItems];
}

enum OptionType {
  SELECT,
  MULTISELECT,
}

///// product option item
class ProductOptionItem extends Equatable {
  final int id;
  final String name;
  final double price;
  const ProductOptionItem(this.id, this.name, this.price);

  @override
  List<Object?> get props => [id, name, price];
}
