import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/account/domain/entities/image.dart';
import 'package:jdolh_flutter/category/domain/entities/store.dart';
import 'package:jdolh_flutter/store/domain/entities/store_branch.dart';

class StoreDetails extends Equatable {
  final int id;
  final String name;
  final String bio;
  final bool isActive;
  final AppImage avatar;
  final AppImage cover;
  final List<StoreRatingSummary> rating;
  final List<StoreBranch> branches;
  StoreDetails(this.id, this.name, this.bio, this.isActive, this.avatar, this.cover, this.branches, this.rating);

  @override
  List<Object?> get props => [id, name, bio, isActive, avatar, cover, branches, rating];
}
