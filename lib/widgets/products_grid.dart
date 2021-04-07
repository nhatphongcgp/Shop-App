import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    // Consumer là một widget cho phép bạn lấy ra được model mà bạn muốn từ phía ChangeNotifierProvider.
    // Bất kỳ widget nào cần dữ liệu từ model để thiết lập trạng thái của nó phải được bao bọc
    //  trong widget Consumer.
    final productsData = Provider.of<Products>(context);
    final products = showFavs
        ? productsData.favoriteItems
        : productsData.items; // product có phải favorites hay không
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        // Tương tự như file main.dart
        // ChangeNotifierProvider được sinh ra để lắng nghe ChangeNotifier.
        //  Các thành phần con sẽ được rebuild khi hàm notifyListener() ở ChangeNotifier được gọi.
        create: (c) => products[i], // Trả về single Product Item
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
