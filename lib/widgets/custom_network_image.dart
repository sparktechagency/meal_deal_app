import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Border? border;
  final double? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;
  final List<BoxShadow>? boxShadow;
  final bool elevation;
  final BoxFit? fit;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
    this.backgroundColor,
    this.child,
    this.colorFilter,
    this.boxShadow,
    this.elevation = false, this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return _buildPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl.trim(),
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius:
          borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
          shape: boxShape,
          boxShadow: boxShadow ??
              (elevation
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  spreadRadius: 6,
                ),
              ]
                  : null),
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
            colorFilter: colorFilter,
          ),
        ),
        child: child,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.6),
        highlightColor: Colors.grey.withOpacity(0.3),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            border: border,
            borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
            shape: boxShape,
            boxShadow: boxShadow ??
                (elevation
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    spreadRadius: 6,
                  ),
                ]
                    : null),
          ),
        ),
      ),
      errorWidget: (context, url, error) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[300],
        border: border,
        borderRadius:
        borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
        shape: boxShape,
        boxShadow: boxShadow ??
            (elevation
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                spreadRadius: 6,
              ),
            ]
                : null),
      ),
      child: const Icon(
        Icons.broken_image_outlined,
        color: Colors.grey,
        size: 24,
      ),
    );
  }
}
