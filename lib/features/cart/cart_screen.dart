import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as itl;
import 'package:task/components/constants/assets_path.dart';
import 'package:task/components/constants/custom_colors.dart';
import 'package:task/components/constants/text_style.dart';
import 'package:task/components/custom_widgets/custom_snackbar.dart';
import 'package:task/controller/cart_controller.dart';
import 'package:task/model/car_models.dart';

import '../../utils/local_data.dart';

class ShoeCartScreen extends StatefulWidget {
  const ShoeCartScreen({super.key});

  @override
  State<ShoeCartScreen> createState() => _ShoeCartScreenState();
}

class _ShoeCartScreenState extends State<ShoeCartScreen> {
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomButton(),
      body: Stack(
        children: [
          _mainBody(),
          _appBar(),
        ],
      ),
    );
  }

  Widget _mainBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SwitchImageWithAnimation(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 26),
                _buildShoeDescription(),
                const SizedBox(height: 24),
                _buildShoeList(),
                const SizedBox(height: 34),
                const SizedBox(
                  width: double.infinity,
                  child: BuildShoeSizes(),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return SafeArea(
      child: Container(
        height: 20,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                CustomSnackBar.showCustomToast(message: "Back Button Pressed");
              },
              child: SvgPicture.asset(SvgPath.arrowBack),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  CustomSnackBar.showCustomToast(message: "Favourite Pressed");
                },
                child: SvgPicture.asset(SvgPath.heart)),
          ],
        ),
      ),
    );
  }

  Widget _buildShoeDescription() {
    var formatter = itl.NumberFormat('#,##,000');
    return GetBuilder<CartController>(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                controller.selectedShoe.name,
                style: GetTextStyleTask.styleS26w900Black,
              ),
              const Spacer(),
              Text(
                "₹${formatter.format(controller.selectedShoe.amount)}",
                style: GetTextStyleTask.styleS18w700Black,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<CartController>(builder: (value) {
            return LayoutBuilder(builder: (context, constraints) {
              var maxLine = value.maxLine;
              final textSpan = TextSpan(
                  text: value.selectedShoe.description,
                  style: GetTextStyleTask.styleS16w400LightBlue);
              final textPainter = TextPainter(
                  textDirection: TextDirection.ltr,
                  text: textSpan,
                  maxLines: maxLine);
              textPainter.layout(maxWidth: constraints.maxWidth);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: textSpan,
                    maxLines: maxLine,
                    overflow: TextOverflow.clip,
                  ),
                  if (textPainter.didExceedMaxLines)
                    InkWell(
                      onTap: () {
                        value.moreTap();
                      },
                      child: Text(
                        !textPainter.didExceedMaxLines ? "" : "More ",
                        style: GetTextStyleTask.styleS18w900Black
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                    )
                ],
              );
            });
          }),
        ],
      );
    });
  }

  Widget _buildShoeList() {
    return GetBuilder<CartController>(builder: (value) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            for (int i = 0; i < value.shoeList.length; i++)
              InkWell(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  value.updateShoe(value.shoeList[i]);
                },
                child: SelectedImage(
                  image: imageList[i],
                  isSelected: value.shoeList[i].id == value.selectedShoe.id,
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                CustomSnackBar.showCustomToast(message: "Add to bag pressed");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.black1F2732,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Add to Bag",
                style: GetTextStyleTask.styleS16w800White,
              )),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class BuildShoeSizes extends StatelessWidget {
  const BuildShoeSizes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Size",
          textAlign: TextAlign.start,
          style: GetTextStyleTask.styleS18w900Black,
        ),
        const SizedBox(height: 9),
        GetBuilder<CartController>(builder: (value) {
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (int i = 0; i < 7; i++)
                InkWell(
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    if (shoeSizes[i].isAvailable) {
                      value.updateSize(i);
                    } else {
                      CustomSnackBar.showCustomToast(
                          message: "Stock is unavailable");
                    }
                  },
                  child: _card(
                    shoeSizes[i],
                    i == value.sizeIndex,
                  ),
                )
            ],
          );
        })
      ],
    );
  }

  _card(ShoeSizeModel model, bool isSelected) {
    if (!model.isAvailable) {
      return Container(
        width: 66,
        height: 40,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: CustomColors.greyF6,
            border: Border.all(
                color: CustomColors.greyDEE, width: isSelected ? 2 : 1),
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          model.title,
          style: isSelected
              ? GetTextStyleTask.styleS18w900Black.copyWith(fontSize: 14)
              : GetTextStyleTask.styleS14w400Black,
        ),
      );
    }
    return Container(
      width: 66,
      height: 40,
      alignment: Alignment.center,
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(
              color:
                  isSelected ? CustomColors.black1F2732 : CustomColors.greyDEE,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        model.title,
        style: isSelected
            ? GetTextStyleTask.styleS18w900Black.copyWith(fontSize: 14)
            : GetTextStyleTask.styleS14w400Black,
      ),
    );
  }
}

class SelectedImage extends StatelessWidget {
  const SelectedImage(
      {super.key, required this.image, this.isSelected = false});

  final String image;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    // padding: isSelected ? EdgeInsets.all(10) : EdgeInsets.zero,
    return Container(
      width: 80,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
            color: isSelected ? CustomColors.black1F2732 : Colors.transparent,
            width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 80,
        height: 64,
        decoration: BoxDecoration(
          color: CustomColors.greyF4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
          ),
        ),
      ),
    );
  }
}

class SwitchImageWithAnimation extends StatelessWidget {
  const SwitchImageWithAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(ImagePath.shoeBackground),
        GetBuilder<CartController>(builder: (value) {
          return Positioned.fill(
            bottom: -100,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final fadeOutAnimation =
                    Tween(begin: 0.0, end: 1.0).animate(animation);

                return FadeTransition(
                  opacity: fadeOutAnimation,
                  child: child,
                );
              },
              child: Image.asset(
                value.selectedShoe.images,
                key: ValueKey<String>(value.selectedShoe.id),
              ),
            ),
          );
        })
      ],
    );
  }
}
