import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    // đếm số lượng sản phẩm khác loại
    return _items.length;
  }

  double get totalAmount {
    // Tổng tiền cho tất cả sản phẩm đã mua
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity.toDouble();
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    // hàm thêm sản phẩm vài giỏ hàng
    if (_items.containsKey(productId)) {
      // Kiểm tra có tồn tại hay không dựa vào Id của sản phẩm nếu có tăng lên số lượng lên bằng update method
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
          // ngược lại nếu không có thì thêm vào
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                title: title,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    // xóa sản phẩm trong Widget giỏ hàng
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    // Hàm này xảy ra trong Widget Product Item (product_item.dart)
    // hàm gở bõ sản phẩm khi người dùng nhấn vào chữ "Hoàn tác"
    if (!_items.containsKey(productId)) {
      // xem có tồn tại sản phẩm hay chưa thông qua Id sản phẩm
      return;
    }
    if (_items[productId].quantity > 1) {
      // khi tồn tại sản phẩm lớn hơn một
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity -
              1, // Giảm đi 1 đơn vị khi hoàn tác thêm vào giỏ hàng
        ),
      );
    } else {
      // khi sản phẩm còn lại 1 tiến hành gỡ bỏ sản phẩm
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    // Xóa sản phẩm khi User nhấn đặt ngay
    // hàm thực hiện trong Widget giỏ hàng
    _items = {};
    notifyListeners();
  }
}
