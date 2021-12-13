import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/home/home_controller.dart';
import 'package:fruitshop/modules/widgets/dialogs/warning_dialog.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  final _canContinue = false.obs;
  set canContinue(value) => _canContinue.value = value;
  get canContinue => _canContinue.value;

  final _finalValue = 0.obs;
  set finalValue(value) => _finalValue.value = value;
  get finalValue => _finalValue.value;

  RxList<ProductModel> products = RxList<ProductModel>([]);

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() => FirebaseFirestore.instance
      .collection("products")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());

  finalSum() {
    var i;

    for (i = 0; i < products.length; i == products.length) {
      if (products[i].counter != 0) {
        finalValue += products[i].finalValue;
        canContinue = true;
      }
      i++;
    }
  }

  goToCart() {
    finalSum();

    if (canContinue) {
      Get.toNamed(RoutesCart.CART)!.then((value) => canContinue = false);
    } else {
      Get.dialog(WarningDialog(
        title: "Erro ao adicionar produto",
        warningDescription: 'Adicione pelo menos um produto!',
        buttonText: 'Voltar',
        buttonCallback: () => Get.back(),
      ));
    }
  }
}
