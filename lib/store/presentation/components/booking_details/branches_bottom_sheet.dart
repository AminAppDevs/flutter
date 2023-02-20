import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/store/domain/entities/store_branch.dart';
import 'package:jdolh_flutter/store/presentation/controller/booking_details_controller.dart';

Container branchesBottomSheet({required List<StoreBranch> branches, required BookingDetailsController bookingDetailsController}) {
  return Container(
    height: 250,
    color: Colors.white,
    padding: const EdgeInsets.all(15),
    child: ListView(
      children: [
        Text(
          'أختر الفرع',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppLightColor.headingColor,
          ),
        ),
        vertical(5),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: branches.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: AppLightColor.inputBgColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      bookingDetailsController.changeSelectedBranch(id: branches[index].id, name: branches[index].name);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(100)),
                          child: Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  bookingDetailsController.selectedBranchId == branches[index].id ? AppLightColor.primaryColor : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        horizontal(6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              branches[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                            Text(
                              '${branches[index].neighborhood.city.name} - ${branches[index].neighborhood.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                        horizontal(5),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      bookingDetailsController.openBranchAddressOnGoogleMap(latitude: branches[index].latitude, longitude: branches[index].longitude);
                    },
                    child: Container(
                      width: 90,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppLightColor.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.map_outline,
                            size: 13,
                            color: Colors.white,
                          ),
                          horizontal(2),
                          Text(
                            'فتح الموقع',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
