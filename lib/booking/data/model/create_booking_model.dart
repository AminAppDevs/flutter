import 'package:jdolh_flutter/booking/domain/entities/create_booking.dart';

class CreateBookingModel extends CreateBooking {
  CreateBookingModel({
    required super.storeBranchId,
    required super.branchReservationDayTimeId,
    required super.dateOfBooking,
    required super.numberOfSeats,
    required super.adminId,
    required super.feeStatusPaid,
    required super.bookingInvoiceType,
    required super.items,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeBranchId'] = this.storeBranchId;
    data['branchReservationDayTimeId'] = this.branchReservationDayTimeId;
    data['dateOfBooking'] = this.dateOfBooking;
    data['numberOfSeats'] = this.numberOfSeats;
    data['adminId'] = this.adminId;
    data['feeStatusPaid'] = this.feeStatusPaid;
    data['bookingInvoiceType'] = this.bookingInvoiceType;
    data['items'] =
        this.items.map((item) => CreateBookingCartItemModel(item.storeProductId, item.quantity, item.price, item.cartItemOptions).toJson()).toList();
    return data;
  }
}

class CreateBookingCartItemModel extends CreateBookingCartItem {
  CreateBookingCartItemModel(super.storeProductId, super.quantity, super.price, super.cartItemOptions);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['storeProductId'] = this.storeProductId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['cartItemOptions'] =
        this.cartItemOptions.map((option) => CreateBookingCartItemOptionModel(option.name, option.quantity, option.price).toJson()).toList();
    return data;
  }
}

class CreateBookingCartItemOptionModel extends CreateBookingCartItemOption {
  const CreateBookingCartItemOptionModel(super.name, super.quantity, super.price);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}
