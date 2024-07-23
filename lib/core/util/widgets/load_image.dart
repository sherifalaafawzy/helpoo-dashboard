import 'package:flutter/cupertino.dart';

class LoadImage extends StatelessWidget {
  final String image;
  Color? color;
  double? width;

  LoadImage({
    super.key,
    required this.image,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$image.png',
      width: width,
      color: color,
    );
  }
}
