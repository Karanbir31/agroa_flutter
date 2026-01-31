import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double radius;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Color? color;
  final String? placeholder;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.radius = 0,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.color,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        color: color,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: height,
            width: width,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => placeholder != null
            ? Image.asset(
                placeholder!,
                height: height,
                width: width,
                fit: fit,
              )
            : Container(
                height: height,
                width: width,
                color: Colors.grey[200],
                child: const Icon(Icons.error_outline, color: Colors.grey),
              ),
      ),
    );
  }
}
