import 'package:equatable/equatable.dart';

class BranchReservationDay extends Equatable {
  final int id;
  final String dayName;
  final List<BranchReservationDayTime> branchReservationDayTimes;
  const BranchReservationDay(this.id, this.dayName, this.branchReservationDayTimes);

  @override
  List<Object?> get props => [id, dayName, branchReservationDayTimes];
}

class BranchReservationDayTime extends Equatable {
  final int id;
  final String from;
  final String to;
  const BranchReservationDayTime(this.id, this.from, this.to);

  @override
  List<Object?> get props => [id, from, to];
}
