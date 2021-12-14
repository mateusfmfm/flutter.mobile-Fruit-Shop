import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruitshop/data/models/order_model.dart';
import 'package:fruitshop/data/utils/pdf_downloader.dart';
import 'package:fruitshop/modules/widgets/dialogs/warning_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class OrderResumController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>([]);

  ScreenshotController screenshotController = ScreenshotController();

  String orderCode = "";

  @override
  onReady() {
    super.onReady();
    orders.bindStream(getAllOrders());
  }

  Stream<List<OrderModel>> getAllOrders() =>
      FirebaseFirestore.instance.collection("order").snapshots().map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());

  setTheOrderModel() async {
    var arguments = Map<dynamic, dynamic>.from(Get.arguments);
    final String orderCode = arguments['orderCode'];

    var document = await FirebaseFirestore.instance
        .collection('order')
        .doc(orderCode)
        .get();
    Map<String, dynamic>? data = document.data();
    print(document.toString());
  }

  takeScreenshot() async {
    PdfDownloader().takeScreenshot(screenshotController, "orderResum");

    if (await Permission.storage.isGranted) {
      Get.dialog(WarningDialog(
        title: "PDF baixado com sucesso.",
        warningDescription:
            "Seu PDF foi transferido para a pasta de downloads do seu dispositivo.",
        buttonText: "Ok, entendi.",
        buttonCallback: () => Get.back(),
      ));
    }
  }
}
