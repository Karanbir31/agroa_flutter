import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetImageWidget extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final double radius;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Color? color;
  final bool isSvg;

  const AssetImageWidget({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.radius = 0,
    this.borderRadius,
    this.fit = BoxFit.contain,
    this.color,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: isSvg || imagePath.toLowerCase().endsWith('.svg')
          ? SvgPicture.asset(
              imagePath,
              height: height,
              width: width,
              fit: fit,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            )
          : Image.asset(
              imagePath,
              height: height,
              width: width,
              fit: fit,
              color: color,
            ),
    );
  }
}
