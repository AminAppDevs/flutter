import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/store/domain/entities/product_details.dart';
import 'package:jdolh_flutter/store/presentation/components/product_slider.dart';
import 'package:jdolh_flutter/store/presentation/controller/cart_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final StoreController storeController = Get.find();
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: controller.productDetails == null
              ? Container()
              : controller.isGetProductDetailsLoading
                  ? loading(
                      color: AppLightColor.primaryColor,
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.productDetails != null && controller.productDetails!.images.isNotEmpty) productSlider(storeController),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.productDetails!.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                vertical(5),
                                Text(
                                  controller.productDetails!.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                if (controller.productDetails!.type == 'SIMPLE')
                                  Container(
                                    color: Colors.grey.shade100,
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${controller.productDetails!.regularPrice} ريال',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: controller.productDetails!.hasDiscount ? AppLightColor.labelColor : AppLightColor.subHeadingColor,
                                            decoration: controller.productDetails!.hasDiscount ? TextDecoration.lineThrough : TextDecoration.none,
                                          ),
                                        ),
                                        horizontal(10),
                                        if (controller.productDetails!.hasDiscount)
                                          Text(
                                            '${controller.productDetails!.salePrice} ريال',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppLightColor.subHeadingColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                vertical(10),
                                if (controller.productDetails!.type != 'SIMPLE')
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.productDetails!.options.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      controller.productDetails!.options.sort((b, a) => a.optionType.toString().compareTo(b.optionType.toString()));
                                      ProductOption option = controller.productDetails!.options[index];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              option.title,
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    fontSize: 15,
                                                    color: AppLightColor.subHeadingColor,
                                                  ),
                                            ),
                                            if (option.optionType == OptionType.SELECT)
                                              GetBuilder<CartController>(
                                                  builder: (controller) => ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: option.optionItems.length,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemBuilder: (context, itemIndex) {
                                                          ProductOptionItem item = option.optionItems[itemIndex];
                                                          var selectedItem =
                                                              cartController.optionItems.firstWhereOrNull((element) => element.optionId == option.id);

                                                          return ListTileTheme(
                                                            contentPadding: EdgeInsets.only(left: 0),
                                                            minVerticalPadding: 0,
                                                            horizontalTitleGap: 0,
                                                            dense: true,
                                                            child: RadioListTile(
                                                              activeColor: AppLightColor.secondaryColor,
                                                              dense: true,
                                                              value: item.id,
                                                              groupValue: selectedItem == null ? 0 : selectedItem.optionItemId,
                                                              title: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(item.name),
                                                                  Text('${item.price} ريال'),
                                                                ],
                                                              ),
                                                              onChanged: (value) {
                                                                cartController.addOptionItemToList(
                                                                  optionId: option.id,
                                                                  isSelect: true,
                                                                  optionName: option.title,
                                                                  optionItemName: item.name,
                                                                  amount: item.price,
                                                                  optionItemId: item.id,
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
          bottomNavigationBar: InkWell(
            onTap: () {},
            child: Container(
              height: 55,
              alignment: Alignment.center,
              color: AppLightColor.primaryColor,
              child: Text(
                'أضف لسلة الحجز',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
