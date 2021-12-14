import 'package:fruitshop/modules/cart/cart_page.dart';
import 'package:fruitshop/modules/home/home_page.dart';
import 'package:fruitshop/modules/login/login_page.dart';
import 'package:fruitshop/modules/order/order_resum_page.dart';
import 'package:fruitshop/modules/product/product_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => LoginPage(),
    ),

    //HOME
    GetPage(
      name: RoutesHome.HOME,
      page: () => HomePage(),
    ),

    //PRODUCT
    GetPage(
      name: RoutesProduct.PRODUCT_LIST,
      page: () => ProductPage(),
    ),

    //CART
    GetPage(
      name: RoutesCart.CART,
      page: () => CartPage(),
    ),

    //ORDER
    GetPage(
      name: RoutesOrder.ORDER_RESUM,
      page: () => OrderResumPage(), 
    ),

    

    
  ];
}
