import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

class CategorySlide extends Equatable {
  final int id;
  final int storeId;
  final AppImage image;
  const CategorySlide(this.id, this.storeId, this.image);
  @override
  List<Object?> get props => [id, storeId, image];
}
