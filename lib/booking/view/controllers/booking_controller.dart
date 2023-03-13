import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/auth/data/datasource/local_auth_datasource.dart';
import 'package:jdolh_flutter/booking/data/model/create_booking_model.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_booking.dart';
import 'package:jdolh_flutter/booking/domain/entities/branch_reservation_day.dart';
import 'package:jdolh_flutter/booking/domain/entities/create_booking.dart';
import 'package:jdolh_flutter/booking/domain/usecases/create_booking_usecase.dart';
import 'package:jdolh_flutter/booking/domain/usecases/get_branch_bookings_by_dates_usecase.dart';
import 'package:jdolh_flutter/booking/domain/usecases/get_branch_reservation_days_usecase.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/store/presentation/controller/cart_controller.dart';

class BookingController extends GetxController {
  final GetBranchReservationDaysUsecase getBranchReservationDaysUsecase;
  final CreateBookingUsecase createBookingUsecase;
  final GetBranchBookingByDatesUsecase getBranchBookingByDatesUsecase;
  BookingController(this.getBranchReservationDaysUsecase, this.createBookingUsecase, this.getBranchBookingByDatesUsecase);

  List<BranchReservationDay> branchReservationDays = [];
  List<BranchBookingByDate> branchBookingsByDates = [];
  bool isGetBranchBookingsByDates = false;
  BranchReservationDay? selectedBranchReservationDay;
  int selectedimeId = 0;
  bool isGetBranchReservationDaysLoading = false;
  DateTime selectedCalenderDay = DateTime.now();
  Map<String, List> events = {};
  bool isFeeStatusPaid = false;
  Timer? timer;

  ///// change selected calender day
  changeSelectedCalenderDay(DateTime selectedDay) {
    selectedCalenderDay = selectedDay;
    update();
    print(selectedCalenderDay);
  }

  changeSelectedReservationDayTimeId(int id) {
    selectedimeId = id;
    update();
  }

  //// get selected branch day with calendar
  getSelectedBranchDayWithCalendar(int dayNumber) {
    print(branchReservationDays);
    switch (dayNumber) {
      case 1:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'الأثنين');
        update();
        break;
      case 2:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'الثلاثاء');
        update();
        break;
      case 3:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'الأربعاء');
        update();
        break;
      case 4:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'الخميس');
        update();
        break;
      case 5:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'الجمعة');
        update();
        break;
      case 6:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'السبت');
        update();
        break;
      case 7:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'الأحد');
        update();
        break;

      default:
        selectedBranchReservationDay = branchReservationDays.firstWhere((day) => day.dayName == 'السبت');
    }
  }

  ///// get branch reservation days
  getBranchReservationDays(int branchId) async {
    isGetBranchReservationDaysLoading = true;
    update();
    Either<Failure, List<BranchReservationDay>> result = await getBranchReservationDaysUsecase(branchId);
    result.fold(
      (Failure failure) {
        isGetBranchReservationDaysLoading = false;
        update();
        print(failure);
      },
      (List<BranchReservationDay> value) {
        branchReservationDays = value;
        isGetBranchReservationDaysLoading = false;
        update();
      },
    );
  }

  ///// create booking
  createBooking({
    required int storeBranchId,
    required int branchReservationDayTimeId,
    required int numberOfSeats,
    required List<CartItem> cart,
  }) {
    int adminId = LocalAuthDatasource().readUserId();
    CreateBookingModel createBookingModel = CreateBookingModel(
      storeBranchId: storeBranchId,
      branchReservationDayTimeId: branchReservationDayTimeId,
      dateOfBooking: selectedCalenderDay.toIso8601String(),
      numberOfSeats: numberOfSeats,
      adminId: adminId,
      feeStatusPaid: isFeeStatusPaid,
      bookingInvoiceType: BookingInvoiceType.JUSTADMIN.name,
      items: createCartBookingItems(cart),
    );
    print(createBookingModel.toJson());
  }

  /// create booking cart items
  List<CreateBookingCartItem> createCartBookingItems(List<CartItem> cart) {
    List<CreateBookingCartItem> items = cart.map((CartItem cartItem) {
      return CreateBookingCartItem(
          cartItem.id,
          cartItem.quantity,
          cartItem.price,
          cartItem.options.map((CartSelectOption option) {
            return CreateBookingCartItemOption(option.name, option.quantity, option.price);
          }).toList());
    }).toList();
    return items;
  }

  //// get branch bookings by date
  getBranchBookingByDate(int branchId, String fromDate, String toDate) async {
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      isGetBranchBookingsByDates = true;
      update();
      print(fromDate);
      print(toDate);
      Either<Failure, List<BranchBookingByDate>> result = await getBranchBookingByDatesUsecase(branchId, fromDate, toDate);
      result.fold(
        (Failure failure) {
          isGetBranchBookingsByDates = false;
          update();
        },
        (List<BranchBookingByDate> value) {
          branchBookingsByDates = value;
          isGetBranchBookingsByDates = false;
          update();
          print(value);
        },
      );
    });
  }
}
