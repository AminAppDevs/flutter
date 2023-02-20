import 'dart:convert';

import 'package:jdolh_flutter/booking/data/datasource/base_remote_booking_datasource.dart';
import 'package:jdolh_flutter/booking/data/model/branch_reservation_day_model.dart';

import 'package:http/http.dart' as http;
import 'package:jdolh_flutter/core/error/exceptions.dart';
import 'package:jdolh_flutter/core/error/server_error_model.dart';
import 'package:jdolh_flutter/core/utils/api_config.dart';

class RemoteBookingDatasource extends BaseRemoteBookingDatasource {
  ///// get branch reservation days
  @override
  Future<List<BranchReservationDayModel>> getBranchReservationDays(int branchId) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getBranchReservationDays}/$branchId';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => BranchReservationDayModel.fromJson(e)).toList();
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
