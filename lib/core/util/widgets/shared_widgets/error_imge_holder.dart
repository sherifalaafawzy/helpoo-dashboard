import 'package:flutter/material.dart';
import '../../assets_images.dart';

class ErrorImageHolder extends StatelessWidget {
  const ErrorImageHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AssetsImages.errorPlaceHolder,
        color: Colors.grey[300],
        fit: BoxFit.contain,
      ),
    );
  }
}
