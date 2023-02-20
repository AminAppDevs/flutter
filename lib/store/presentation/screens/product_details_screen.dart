import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/store/domain/entities/product_details.dart';
import 'package:jdolh_flutter/store/presentation/components/cart_bottom_sheet.dart';
import 'package:jdolh_flutter/store/presentation/components/product_slider.dart';
import 'package:jdolh_flutter/store/presentation/controller/cart_controller.dart';
import 'package:jdolh_flutter/store/presentation/controller/store_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final StoreController storeController = Get.find();
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                cartBottomSheet(cartController: cartController),
              );
            },
            icon: GetBuilder<CartController>(
              builder: (controller) => Stack(
                children: [
                  Icon(Ionicons.cart),
                  if (cartController.cart.isNotEmpty)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<StoreController>(
        builder: (controller) => controller.productDetails == null
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
                                                      cartController.cartSelectOptions.firstWhereOrNull((element) => element.id == item.id);

                                                  return ListTileTheme(
                                                    contentPadding: EdgeInsets.only(left: 0),
                                                    minVerticalPadding: 0,
                                                    horizontalTitleGap: 0,
                                                    dense: true,
                                                    child: RadioListTile(
                                                      activeColor: AppLightColor.secondaryColor,
                                                      contentPadding: const EdgeInsets.all(0),
                                                      visualDensity: VisualDensity.compact,
                                                      dense: true,
                                                      value: item.id,
                                                      groupValue: selectedItem == null ? 0 : selectedItem.id,
                                                      title: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(item.name),
                                                          Text('${item.price} ريال'),
                                                        ],
                                                      ),
                                                      onChanged: (value) {
                                                        cartController.addCartSelectOption(
                                                          CartSelectOption(
                                                            id: item.id,
                                                            name: item.name,
                                                            price: item.price,
                                                            quantity: 1,
                                                            optionId: option.id,
                                                            title: option.title,
                                                          ),
                                                        );
                                                        cartController.getOptionsTotalPrice(storeController.productDetails!.id);
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
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
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ProductDetails product = storeController.productDetails!;
          bool isSimple = storeController.productDetails!.type == 'SIMPLE' ? true : false;
          cartController.addToCart(id: product.id, name: product.name, price: product.salePrice, quantity: 1, isSimple: isSimple);
        },
        child: Container(
          height: 55,
          alignment: Alignment.center,
          color: AppLightColor.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('أضف لسلة الحجز', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              horizontal(10),
              GetBuilder<CartController>(
                builder: (_controller) => Text(
                  '${cartController.totalPrice} ريال',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
