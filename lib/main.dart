import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // ChangeNotifierProvider được sinh ra để lắng nghe ChangeNotifier.
      //  Các thành phần con sẽ được rebuild khi hàm notifyListener() ở ChangeNotifier được gọi.
      create: (ctx) => Products(),
      child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          // định nghĩa một bản đồ (Map) chứa các trang chính của ứng dụng và
          //  tên tương ứng của chúng, sau đó sử dụng Navigator để di chuyển tới các trang khác nhau
          //  dựa trên các tên này.
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          }),
    );
  }
}
