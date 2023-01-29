import 'package:get/get.dart';

class CartController extends GetxController {
  List<CartItem> cart = [];
  List<OptionItem> optionItems = [];
  List<Map> selectedRadios = [];

  /// add simple item to cart
  addSimpleItemToCart({required int productId, required String productName, required double amount, required int quantity}) {
    SimpleCartItem item = SimpleCartItem(productId, productName, amount, quantity);
    cart.add(item);
    update();
    print(cart);
  }

  /// add option item to list
  addOptionItemToList(
      {required int optionId,
      required bool isSelect,
      required String optionName,
      required String optionItemName,
      required double amount,
      required int optionItemId}) {
    OptionItem optionItem = OptionItem(optionId, isSelect, optionName, optionItemName, amount, optionItemId);
    if (isSelect) {
      var item = optionItems.firstWhereOrNull((element) => element.optionId == optionId);
      if (item == null) {
        List<OptionItem> newOptionsItem = [...optionItems, optionItem];
        optionItems = newOptionsItem;
        update();
      } else {
        optionItems.removeWhere((element) => element.optionId == optionId);
        List<OptionItem> newOptionsItem = [...optionItems, optionItem];
        optionItems = newOptionsItem;
        update();
      }
    }
    update();
    print(optionItems);
  }

  /// add variable item to cart
  addVariableItemToCart({required int productId, required String productName}) {
    VariableCartProduct item = VariableCartProduct(productId, productName, optionItems);
    cart.add(item);
    update();
    print(cart);
  }
}

abstract class CartItem {
  const CartItem(this.productId, this.productName);
  final int? productId;
  final String? productName;
}

class SimpleCartItem extends CartItem {
  const SimpleCartItem(super.productId, super.productName, this.amount, this.quantity);
  final double? amount;
  final int? quantity;
}

class VariableCartProduct extends CartItem {
  const VariableCartProduct(super.productId, super.productName, this.optionItems);
  final List<OptionItem> optionItems;
}

class OptionItem {
  const OptionItem(this.optionId, this.isSelect, this.optionName, this.optionItemName, this.amount, this.optionItemId);
  final int optionId;
  final int optionItemId;
  final bool isSelect;
  final String optionName;
  final String optionItemName;
  final double amount;
}
