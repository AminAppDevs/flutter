import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/store/presentation/components/booking_details/branches_bottom_sheet.dart';
import 'package:jdolh_flutter/store/presentation/controller/booking_details_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

Column branchSeatTimeBooking({
  required BookingDetailsController bookingDetailsController,
  required StoreController storeController,
  required TextEditingController seatNumberController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أختر الفرع',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppLightColor.headingColor,
                  ),
                ),
                vertical(5),
                GetBuilder<BookingDetailsController>(
                  builder: (controller) {
                    return InkWell(
                      onTap: () {
                        Get.bottomSheet(GetBuilder<BookingDetailsController>(
                          builder: (controller) {
                            return branchesBottomSheet(
                                branches: storeController.storeDetails!.branches, bookingDetailsController: bookingDetailsController);
                          },
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppLightColor.inputBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bookingDetailsController.selectedBranchName.isEmpty ? 'تصفح الفروع' : bookingDetailsController.selectedBranchName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Ionicons.chevron_down,
                              color: AppLightColor.labelColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          horizontal(6),
          Container(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عدد المقاعد',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppLightColor.headingColor,
                  ),
                ),
                vertical(5),
                TextFormField(
                  controller: seatNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'فارغ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: '0',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      vertical(6),
      Text(
        'وقت وتاريخ الحجز',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppLightColor.headingColor,
        ),
      ),
      GetBuilder<BookingDetailsController>(
        builder: (controller) {
          return InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              height: 50,
              decoration: BoxDecoration(
                color: AppLightColor.inputBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bookingDetailsController.bookingTime.isEmpty ? 'اختر وقت وتاريخ الحجز' : bookingDetailsController.bookingTime,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                    Ionicons.calendar_outline,
                    color: AppLightColor.subHeadingColor,
                    size: 25,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
