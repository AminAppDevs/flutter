import 'dart:convert';

import 'package:jdolh_flutter/booking/data/datasource/base_remote_booking_datasource.dart';
import 'package:jdolh_flutter/booking/data/model/branch_booking_by_date_model.dart';
import 'package:jdolh_flutter/booking/data/model/branch_reservation_day_model.dart';
import 'package:http/http.dart' as http;
import 'package:jdolh_flutter/booking/data/model/create_booking_model.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_response_model.dart';
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

///// create booking
  @override
  Future<CreateBookingResponseModel> createBooking(CreateBookingModel createBooking) async {
    print(jsonEncode(createBooking.toJson()));
    final String url = '${ApiConfig.baseUrl}${ApiConfig.createBooking}';
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(createBooking.toJson()),
    );
    if (response.statusCode == 201) {
      return CreateBookingResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }

///// get branch booking by date
  @override
  Future<List<BranchBookingByDateModel>> getBranchBookingByDates(int branchId, String fromDate, String toDate) async {
    final String url = '${ApiConfig.baseUrl}${ApiConfig.getBranchBookingsOfDates}/$branchId';
    http.Response response = await http.post(Uri.parse(url), body: {"fromDate": fromDate, "toDate": toDate});
    if (response.statusCode == 201) {
      return (jsonDecode(response.body) as List).map((e) => BranchBookingByDateModel.fromJson(e)).toList();
    } else {
      print(response.body);
      throw ServerException(ServerErrorModel.fromJson(jsonDecode(response.body)));
    }
  }
}
