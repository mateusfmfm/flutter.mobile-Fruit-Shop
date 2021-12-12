import 'package:get/get.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  handleLogin() {
    isLoading = true;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        isLoading = false;
      },
    );
  }
}
