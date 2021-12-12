import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;


  @override
  void onInit() {
    super.onInit();
    ProductController productController = Get.put(ProductController());
    productController.getAllProducts();
  }
}
