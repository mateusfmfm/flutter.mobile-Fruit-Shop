import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitshop/data/models/product_model.dart';
import 'package:fruitshop/modules/home/home_controller.dart';
import 'package:fruitshop/modules/widgets/dialogs/warning_dialog.dart';
import 'package:fruitshop/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:diacritic/diacritic.dart';

class ProductController extends GetxController {
  final _isLoading = false.obs;
  set isLoading(value) => _isLoading.value = value;
  get isLoading => _isLoading.value;

  final _isSearched = false.obs;
  set isSearched(value) => _isSearched.value = value;
  get isSearched => _isSearched.value;

  final _canContinue = false.obs;
  set canContinue(value) => _canContinue.value = value;
  get canContinue => _canContinue.value;

  final _finalValue = 0.obs;
  set finalValue(value) => _finalValue.value = value;
  get finalValue => _finalValue.value;

  RxList<ProductModel> products = RxList<ProductModel>([]);

  List<ProductModel> productList = [];

  final textFilter = "".obs;
  final productListFiltered = <ProductModel>[].obs;

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  onInit() {
    super.onInit();
    // Sistema de filtragrem
    ever(textFilter, listFilter);
    getAllProducts();
  }

  listFilter(value) {
    productListFiltered.value = products
        .where((productItem) => (removeDiacritics(productItem.name!))
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
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
