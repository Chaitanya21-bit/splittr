import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String path;

  const AppImage({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}
