import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';

class BranchReservationDayModel extends BranchReservationDay {
  const BranchReservationDayModel(super.id, super.dayName, super.branchReservationDayTimes);

  factory BranchReservationDayModel.fromJson(Map<String, dynamic> json) => BranchReservationDayModel(
        json['id'],
        json['dayName'],
        (json['branchReservationDayTimes'] as List).map((e) => BranchReservationDayTimeModel.fromJson(e)).toList(),
      );
}

class BranchReservationDayTimeModel extends BranchReservationDayTime {
  const BranchReservationDayTimeModel(super.id, super.from, super.to);

  factory BranchReservationDayTimeModel.fromJson(Map<String, dynamic> json) => BranchReservationDayTimeModel(
        json['id'],
        json['from'],
        json['to'],
      );
}
