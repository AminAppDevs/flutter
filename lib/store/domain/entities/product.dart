import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final String type;
  final double regularPrice;
  final double salePrice;
  final bool hasDiscount;
  final List<AppImage> images;
  const Product(this.id, this.name, this.description, this.images, this.type, this.regularPrice, this.salePrice, this.hasDiscount);

  @override
  List<Object?> get props => [id, name, description, images];
}
