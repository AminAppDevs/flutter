import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/store/domain/entities/product.dart';

class ProductCategory extends Equatable {
  final int id;
  final String name;
  final int storeId;
  final List<Product> products;
  const ProductCategory(this.id, this.name, this.storeId, this.products);

  @override
  List<Object?> get props => [id, name, storeId, products];
}
