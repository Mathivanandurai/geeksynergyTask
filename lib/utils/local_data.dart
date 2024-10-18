import 'package:task/components/constants/assets_path.dart';
import 'package:task/controller/cart_controller.dart';

import '../model/car_models.dart';

List<String> imageList = [
  ImagePath.shoe1,
  ImagePath.shoe2,
  ImagePath.shoe3,
];

List<ShoeSizeModel> shoeSizes = List<ShoeSizeModel>.generate(
    8,
    (e) => ShoeSizeModel(
        title: 'Uk ${e + 6}', isAvailable: e == 3 ? false : true));
String description =
    "In the game's crucial moments, KD thrives. He takes over on both ends of the court, making defenders fear his unstopped";

var shoeLists = [
  ShoeModel(
    id: "1",
    description:
        "In the game's crucial moments, KD thrives. He takes over on both ends of the court, making defenders fear He takes over on both ends of the court, making defenders fear",
    amount: 12995,
    name: "KD11 EP",
    images: ImagePath.shoe1,
  ),
  ShoeModel(
    id: "2",
    description:
        "A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection",
    amount: 9547,
    name: "KD13 EP",
    images: ImagePath.shoe2,
  ),
  ShoeModel(
    id: "3",
    description:
        "footwear shaped to fit the foot (below the ankle) with a flexible upper of leather or plastic and a sole and heel of heavier material",
    amount: 8547,
    name: "KD183 EP",
    images: ImagePath.shoe3,
  ),
];
