import 'package:flutter/material.dart';

import '../constants/radius_constants.dart';

class RoundedButton extends StatelessWidget {
  final double height;
  final bool scale;
  final double radius;
  final String title;
  final double? width;
  final Color titleColor;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const RoundedButton({
    this.height = 50,
    this.scale = true,
    this.radius = RadiusConstants.buttonRadius,
    this.title = "Go",
    this.titleColor = Colors.white,
    this.backgroundColor = KDarkColors.kPrimaryColor,
    this.onPressed,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: scale ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: titleColor,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            )),
        child: Text(title),

      ),
    );
  }
}
