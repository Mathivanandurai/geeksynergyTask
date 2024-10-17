
import 'package:flutter/material.dart';


class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.radius = 0,
    this.borderRadius,
    this.errorWidget,
  });

  final String image;
  final double? width;
  final double? height;
  final double radius;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:borderRadius ?? BorderRadius.circular(radius),
        ),
        child: Image.network(
          image,
          width: width,
          height: height,
          fit: BoxFit.fill,
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: frame != null ? child : _loader(),
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return _loader();
          },
          errorBuilder: (_, s, e) {
            return
                SizedBox(
                  width: width,
                  height: height,
                  child:errorWidget ?? const Icon(Icons.error),
                );
          },
        ),
      ),
    );
  }

  Widget _loader() {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.withOpacity(0.8),
    );
    // return Shimmer.fromColors(
    //   baseColor: Colors.grey[300]!,
    //   highlightColor: Colors.grey[100]!,
    //   child: Container(
    //     height: height,
    //     width: width,
    //     color: Colors.blue,
    //   ),
    // );
  }
}
