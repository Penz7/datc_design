import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/index.dart';

/// A high-performance image widget that supports caching and shimmer loading.
///
/// Use [DCImage] to display network images with a consistent design system.
class DCImage extends StatelessWidget {
  const DCImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.backgroundColor,
    this.useShimmer = true,
  });

  /// The URL of the network image.
  final String imageUrl;

  /// Optional width of the image.
  final double? width;

  /// Optional height of the image.
  final double? height;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  /// Optional border radius for rounded corners.
  final BorderRadius? borderRadius;

  /// Optional custom placeholder widget shown while loading.
  final Widget? placeholder;

  /// Optional custom widget shown when image loading fails.
  final Widget? errorWidget;

  /// Background color for the image container.
  final Color? backgroundColor;

  /// Whether to use the built-in shimmer effect as a placeholder.
  final bool useShimmer;

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          (useShimmer ? _buildShimmer() : _buildDefaultPlaceholder()),
      errorWidget: (context, url, error) => errorWidget ?? _buildErrorWidget(),
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return Container(
      key: const Key('dc_image_container'),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? DCColors.gray100,
        borderRadius: borderRadius,
      ),
      child: image,
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: DCColors.gray200,
      highlightColor: DCColors.gray100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(DCColors.primary),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: DCColors.gray200,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: DCColors.gray500,
          size: 24,
        ),
      ),
    );
  }
}
