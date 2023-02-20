import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  List<CartItem> cart = [];
  List<CartSelectOption> cartSelectOptions = [];
  double totalPrice = 0;

  /// add to cart
  void addToCart({required int id, required String name, required double price, required int quantity, required bool isSimple}) {
    var uuid = Uuid();
    if (isSimple) {
      cart.add(CartItem(options: [], id: id, name: name, price: price, quantity: quantity, uuid: uuid.v4()));
      update();
      print(cart);
    } else {
      if (cart.where((element) => element.id == id).toList().isEmpty) {
        cart.add(CartItem(options: cartSelectOptions, id: id, name: name, price: price, quantity: quantity, uuid: uuid.v4()));
        update();
        print(cart);
      } else {
        print('المنتج موجود مسبقاً في السلة');
      }
    }
  }

  /// add cart selected option
  void addCartSelectOption(CartSelectOption cartSelectOption) {
    List<CartSelectOption> selectedItem = cartSelectOptions.where((element) => element.optionId == cartSelectOption.optionId).toList();
    if (selectedItem.isEmpty) {
      cartSelectOptions.add(cartSelectOption);
      update();
    } else {
      cartSelectOptions.removeWhere((element) => element.optionId == cartSelectOption.optionId);
      cartSelectOptions.add(cartSelectOption);
      update();
    }
  }

  /// calculate variable product price
  getOptionsTotalPrice(int cartItemId) {
    double total = cartSelectOptions.fold(0, (previousValue, element) => previousValue + element.price);
    totalPrice = total;
    update();
    print(total);
  }

  /// calculate cart total

  void removeFromCart(CartItem item) {
    cart.remove(item);
    update();
  }

  void incrementItemQty(CartItem item) {
    item.quantity++;
    update();
  }

  void decrementItemQty(CartItem item) {
    item.quantity--;
    update();
  }

  // void incrementOptionQty(VariableCartItem item, CartSelectOption option) {
  //   option.quantity++;
  //   update();
  // }

  // void decrementOptionQty(VariableCartItem item, CartSelectOption option) {
  //   option.quantity--;
  //   update();
  // }
}

class CartItem {
  final int id;
  final String name;
  final double price;
  final String uuid;
  List<CartSelectOption> options = [];
  int quantity;

  CartItem({
    required this.uuid,
    required this.options,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  toString() {
    return 'id: $id, name: $name, price: $price, options: ${options.length}';
  }
}

class CartSelectOption {
  final int id;
  final int optionId;
  final String title;
  final String name;
  final double price;
  int quantity;

  CartSelectOption({
    required this.title,
    required this.optionId,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
