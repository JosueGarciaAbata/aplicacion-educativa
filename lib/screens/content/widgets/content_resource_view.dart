import 'dart:io';

import 'package:aplicacion_educativa/data/database.dart';
import 'package:flutter/material.dart';

class ContentResourceView extends StatelessWidget {
  const ContentResourceView({
    super.key,
    required this.content,
    this.height = 220,
  });

  final Content content;
  final double height;

  @override
  Widget build(BuildContext context) {
    final normalizedType = content.type.trim().toLowerCase();

    if (normalizedType == 'texto') {
      return _TextResourceCard(
        resourcePath: content.resourcePath,
        fallbackText: content.description,
      );
    }

    if (normalizedType == 'imagen') {
      return _ImageResourceCard(
        resourcePath: content.resourcePath,
        height: height,
      );
    }

    return _MultimediaResourceCard(
      resourcePath: content.resourcePath,
      height: height,
    );
  }
}

class _TextResourceCard extends StatelessWidget {
  const _TextResourceCard({
    required this.resourcePath,
    required this.fallbackText,
  });

  final String? resourcePath;
  final String? fallbackText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _resolveText(),
      builder: (context, snapshot) {
        final text = snapshot.data;
        final displayText = text == null || text.trim().isEmpty
            ? 'Este contenido no incluye texto adicional.'
            : text;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFD9D3C9)),
          ),
          child: Text(
            displayText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF223129),
              height: 1.55,
            ),
          ),
        );
      },
    );
  }

  Future<String> _resolveText() async {
    if (_hasValue(resourcePath)) {
      final file = File(resourcePath!);
      if (await file.exists()) {
        return file.readAsString();
      }
    }

    return fallbackText?.trim() ?? '';
  }
}

class _ImageResourceCard extends StatelessWidget {
  const _ImageResourceCard({
    required this.resourcePath,
    required this.height,
  });

  final String? resourcePath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
      future: _resolveImageProvider(),
      builder: (context, snapshot) {
        final imageProvider =
            snapshot.data ?? const AssetImage('lib/assets/default.png');

        return ClipRRect(
          borderRadius: BorderRadius.circular(22),
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
    if (_hasValue(resourcePath) && _isValidImagePath(resourcePath!)) {
      final file = File(resourcePath!);
      if (await file.exists()) {
        return FileImage(file);
      }
    }

    return const AssetImage('lib/assets/default.png');
  }
}

class _MultimediaResourceCard extends StatelessWidget {
  const _MultimediaResourceCard({
    required this.resourcePath,
    required this.height,
  });

  final String? resourcePath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasUsableImage(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return _ImageResourceCard(
            resourcePath: resourcePath,
            height: height,
          );
        }

        return Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF1EEE8),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFD9D3C9)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.perm_media_outlined,
                size: 42,
                color: Color(0xFF6A746D),
              ),
              const SizedBox(height: 12),
              Text(
                'Este contenido no incluye material multimedia',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF334138),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_hasValue(resourcePath)) ...[
                const SizedBox(height: 8),
                Text(
                  'Ruta local: ${resourcePath!}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF677068),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<bool> _hasUsableImage() async {
    if (!_hasValue(resourcePath) || !_isValidImagePath(resourcePath!)) {
      return false;
    }

    return File(resourcePath!).exists();
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
