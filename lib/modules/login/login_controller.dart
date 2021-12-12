import 'package:fruitshop/modules/home/home_page.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  handleLogin() {
    isLoading = true;
    Future.delayed(
      Duration(seconds: 3),
      () {
        isLoading = false;
        Get.offAndToNamed(RoutesHome.HOME);
        print("iuiuiui");
      },
    );
  }
}
