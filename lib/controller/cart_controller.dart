import 'package:get/get.dart';
import 'package:task/utils/local_data.dart';

import '../model/car_models.dart';

class CartController extends GetxController {
  List<ShoeModel> shoeList = shoeLists;
  var sizeList = shoeSizes;
  late ShoeModel selectedShoe;
  int sizeIndex = 0;
  int? maxLine = 2;

  updateShoe(ShoeModel index) {
    selectedShoe = index;
    maxLine=3;
    update();
  }

  moreTap() {
    maxLine = null;
    update();
  }

  updateSize(int index) {
    sizeIndex = index;
    update();
  }

  @override
  void onInit() {
    selectedShoe = shoeList.first;
    super.onInit();
  }
}
