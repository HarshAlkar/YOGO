import 'package:flutter/material.dart';

class PoseImage extends StatelessWidget {
  final String imageRef;
  final Map<String, String> images;
  final double? width;
  final double? height;
  final BoxFit fit;

  const PoseImage({
    super.key,
    required this.imageRef,
    required this.images,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final String? imagePath = images[imageRef];
    
    if (imagePath == null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
          size: 48,
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assest/images/$imagePath',
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 48,
              ),
            );
          },
        ),
      ),
    );
  }
} 