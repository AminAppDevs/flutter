import 'package:equatable/equatable.dart';

///// create booking
class CreateBooking extends Equatable {
  final int storeBranchId;
  final int branchReservationDayTimeId;
  final String dateOfBooking;
  final int numberOfSeats;
  final int adminId;
  final bool feeStatusPaid;
  final String bookingInvoiceType;
  final List<CreateBookingCartItem> items;
  const CreateBooking({
    required this.storeBranchId,
    required this.branchReservationDayTimeId,
    required this.dateOfBooking,
    required this.numberOfSeats,
    required this.adminId,
    required this.feeStatusPaid,
    required this.bookingInvoiceType,
    required this.items,
  });

  @override
  List<Object?> get props =>
      [storeBranchId, branchReservationDayTimeId, dateOfBooking, numberOfSeats, adminId, feeStatusPaid, bookingInvoiceType, items];
}

enum BookingInvoiceType { SLICE, JUSTADMIN }

///// booking cart item
class CreateBookingCartItem extends Equatable {
  final int storeProductId;
  final int quantity;
  final double price;
  final List<CreateBookingCartItemOption> cartItemOptions;
  const CreateBookingCartItem(this.storeProductId, this.quantity, this.price, this.cartItemOptions);

  @override
  List<Object?> get props => [storeProductId, quantity, price, cartItemOptions];
}

///// booking cart item option
class CreateBookingCartItemOption extends Equatable {
  final String name;
  final int quantity;
  final double price;
  const CreateBookingCartItemOption(this.name, this.quantity, this.price);

  @override
  List<Object?> get props => [name, quantity, price];
}
