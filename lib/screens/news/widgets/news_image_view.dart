import 'dart:io';

import 'package:flutter/material.dart';

class NewsImageView extends StatelessWidget {
  const NewsImageView({
    super.key,
    required this.imagePath,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
  });

  final String? imagePath;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
      future: _resolveImageProvider(),
      builder: (context, snapshot) {
        final imageProvider =
            snapshot.data ?? const AssetImage('lib/assets/default.png');

        return ClipRRect(
          borderRadius: borderRadius,
          child: Image(
            image: imageProvider,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Future<ImageProvider> _resolveImageProvider() async {
    if (_hasValue(imagePath) && _isValidImagePath(imagePath!)) {
      final file = File(imagePath!);
      if (await file.exists()) {
        return FileImage(file);
      }
    }

    return const AssetImage('lib/assets/default.png');
  }
}

bool _hasValue(String? value) => value != null && value.trim().isNotEmpty;

bool _isValidImagePath(String path) {
  final normalized = path.toLowerCase();
  return normalized.endsWith('.png') ||
      normalized.endsWith('.jpg') ||
      normalized.endsWith('.jpeg') ||
      normalized.endsWith('.webp') ||
      normalized.endsWith('.gif') ||
      normalized.endsWith('.bmp');
}
