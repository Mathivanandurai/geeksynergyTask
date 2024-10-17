import 'package:flutter/material.dart';

import '../constants/text_style.dart';


class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? leading;
  final bool? isNameFontSize;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool? leadingEnable;
  final Color? textColor;
  final bool? isShadowEnable;
  final bool? isBorderLineEnable;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Widget? titleWidget;
  final double? leadingWidth;
  final double preSize;

  const CustomAppBar({
    super.key,
    this.title = "",
    this.leading,
    this.backgroundColor,
    this.centerTitle = false,
    this.textColor,
    this.actions,
    this.bottom,
    this.leadingEnable = true,
    this.isShadowEnable = true,
    this.isBorderLineEnable = true,
    this.isNameFontSize = false,
    this.titleWidget,
    this.leadingWidth,
    this.preSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, preSize),
      child: SafeArea(
        child: AppBar(
          toolbarHeight: 66,
          leading: leading,
          leadingWidth: leadingWidth,
          automaticallyImplyLeading: true,
          surfaceTintColor: backgroundColor,
          title: titleWidget ??
              Text(
                title,
                style: GetTextStyleTask.styleS20w700Black
                    .copyWith(color: Colors.white),
              ),
          elevation: 0,
          centerTitle: centerTitle,
          // iconTheme: IconThemeData(color: CustomColor.primaryColor),
          backgroundColor: backgroundColor ?? Colors.blueAccent,
          actions: actions,
          bottom: bottom,
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size(double.infinity, preSize);
}
