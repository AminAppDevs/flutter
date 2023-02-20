import 'package:flutter/material.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/store/presentation/controller/cart_controller.dart';

Container cartBottomSheet({required CartController cartController}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('السلة الخاصة بك', style: TextStyle(fontSize: 18, color: AppLightColor.headingColor, fontWeight: FontWeight.w600)),
        vertical(10),
        Expanded(
          child: ListView.builder(
            itemCount: cartController.cart.length,
            itemBuilder: (context, index) {
              List<CartSelectOption> total = cartController.cart[index].options;
              double totalPrice = total.fold(0, (previousValue, element) => previousValue + element.price);
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cartController.cart[index].name,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppLightColor.headingColor.withOpacity(.8),
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'المجموع: ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppLightColor.labelColor,
                                height: 1,
                              ),
                            ),
                            Text(
                              totalPrice.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppLightColor.primaryColor,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                            Text(
                              ' ريال',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppLightColor.labelColor,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    vertical(10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartController.cart[index].options.length,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey.shade200)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${cartController.cart[index].options[i].title}: ${cartController.cart[index].options[i].name}',
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1,
                                ),
                              ),
                              Text(
                                '${cartController.cart[index].options[i].price} ريال',
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1,
                                  color: AppLightColor.subHeadingColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey.shade200)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الكمية',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1,
                            ),
                          ),
                          Text(
                            '${cartController.cart[index].quantity}',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1,
                              color: AppLightColor.subHeadingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
