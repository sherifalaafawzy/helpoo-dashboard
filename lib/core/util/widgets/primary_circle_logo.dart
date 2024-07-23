import 'package:flutter/material.dart';
import '../assets_images.dart';
import '../constants.dart';
import 'package:hexcolor/hexcolor.dart';


class PrimaryCircleLogo extends StatelessWidget {
  final double radius;

  const PrimaryCircleLogo({
    super.key,
    this.radius = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: HexColor(mainColor),
      backgroundImage:  const AssetImage(
        AssetsImages.logo,
      ),
    );
  }
}
