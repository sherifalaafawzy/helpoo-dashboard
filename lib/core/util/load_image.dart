import 'package:flutter/material.dart';

class LoadImage extends StatelessWidget {
  final String image;

  const LoadImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(
        image,
      ),
    );
  }
}