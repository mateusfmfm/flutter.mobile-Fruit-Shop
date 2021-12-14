import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruitshop/modules/home/home_page.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  Future<void> handleLogin() async {
    isLoading = true;
    try {
      await FirebaseAuth.instance.signInAnonymously();
      isLoading = false;
      Get.offAndToNamed(RoutesHome.HOME);
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }
}
