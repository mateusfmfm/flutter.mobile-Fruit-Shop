import 'package:fruitshop/modules/home/home_page.dart';
import 'package:fruitshop/modules/login/login_page.dart';
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
  ];
}
