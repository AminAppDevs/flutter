import 'package:equatable/equatable.dart';

class AppImage extends Equatable {
  final int id;
  final String imageUrl;
  final String imageKey;

  const AppImage(this.id, this.imageUrl, this.imageKey);

  @override
  List<Object?> get props => [id, imageUrl, imageKey];
}
