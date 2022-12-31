import 'package:jdolh_flutter/store/domain/entities/neighborhood.dart';
import 'package:jdolh_flutter/store/domain/entities/store_branch.dart';

class StoreBranchModel extends StoreBranch {
  StoreBranchModel(super.id, super.name, super.latitude, super.longitude, super.isActive, super.phone, super.numberOfTables, super.neighborhood);
  factory StoreBranchModel.fromJson(Map<String, dynamic> json) => StoreBranchModel(
        json['id'],
        json['name'],
        json['latitude'],
        json['longitude'],
        json['isActive'],
        json['phone'],
        json['numberOfTables'],
        NeighborhoodModel.fromJson(
          json['neighborhood'],
        ),
      );
}

class NeighborhoodModel extends Neighborhood {
  NeighborhoodModel(super.id, super.name, super.city);
  factory NeighborhoodModel.fromJson(Map<String, dynamic> json) => NeighborhoodModel(
        json['id'],
        json['name'],
        CityModel.fromJson(
          json['city'],
        ),
      );
}

class CityModel extends City {
  CityModel(super.id, super.name);
  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        json['id'],
        json['name'],
      );
}
