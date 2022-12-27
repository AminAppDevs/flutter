import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';

class Store extends Equatable {
  final int id;
  final String name;
  final String bio;
  final bool isActive;
  final AppImage avatar;
  final AppImage cover;
  final List<StoreRatingSummary> rating;
  const Store(this.id, this.name, this.bio, this.isActive, this.avatar, this.cover, this.rating);

  @override
  List<Object?> get props => [id, name, bio, isActive, avatar, cover, rating];
}

class StoreRatingSummary extends Equatable {
  final int id;
  final double rate;
  const StoreRatingSummary(this.id, this.rate);

  @override
  List<Object?> get props => [id, rate];
}
