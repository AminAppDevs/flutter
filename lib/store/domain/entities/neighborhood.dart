import 'package:equatable/equatable.dart';

class Neighborhood extends Equatable {
  final int id;
  final String name;
  final City city;
  const Neighborhood(this.id, this.name, this.city);

  @override
  List<Object?> get props => [id, name, city];
}

class City extends Equatable {
  final int id;
  final String name;
  const City(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}
