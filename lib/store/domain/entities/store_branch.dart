import 'package:equatable/equatable.dart';
import 'package:jdolh_flutter/store/domain/entities/neighborhood.dart';

class StoreBranch extends Equatable {
  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final bool isActive;
  final String phone;
  final int numberOfTables;
  final Neighborhood neighborhood;
  StoreBranch(this.id, this.name, this.latitude, this.longitude, this.isActive, this.phone, this.numberOfTables, this.neighborhood);

  @override
  List<Object?> get props => [id, name, latitude, longitude, isActive, phone, numberOfTables, neighborhood];
}
