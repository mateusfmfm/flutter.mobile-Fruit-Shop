import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruitshop/modules/order/01_order_resum/order_resum_controller.dart';
import 'package:fruitshop/modules/product/product_controller.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  OrderResumController orderResumController = Get.put(OrderResumController());
  ProductController productController = Get.put(ProductController());
  @override
  void onInit() {
    super.onInit();
    //GET PRODUCTS

    productController.getAllProducts();
    //GET ORDERS

    orderResumController.getAllOrders();
  }

  goToShop() {
    Get.toNamed(RoutesProduct.PRODUCT_LIST);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAndToNamed(Routes.INITIAL);
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }
}
