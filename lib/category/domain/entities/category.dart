import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final AppImage icon;
  final AppImage banner;
  const Category(this.id, this.name, this.icon, this.banner);

  @override
  List<Object?> get props => [id, name, icon, banner];
}
