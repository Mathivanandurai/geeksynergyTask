import 'package:flutter/material.dart';
import 'package:task/components/constants/text_style.dart';

class CustomLabelField extends StatelessWidget {
  const CustomLabelField({
    super.key,
    this.child,
    this.color,
    required this.title,
    this.gap = 10,
    this.subTitle,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w700,
    this.isRequired = false,
  });

  final Widget? child;
  final Color? color;
  final String title;
  final String? subTitle;
  final double? gap;
  final bool isRequired;
  final double? fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GetTextStyleTask.styleS20w700Black.copyWith(
            color: color ?? Colors.black,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        SizedBox(height: gap),
        child ?? const SizedBox.shrink()
      ],
    );
  }
}
