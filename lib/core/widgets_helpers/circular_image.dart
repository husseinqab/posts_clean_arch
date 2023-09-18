import 'package:flutter/material.dart';
import '../constants/radius_constants.dart';
import 'networking_image.dart';

class CurvedImage extends StatelessWidget {
  final bool isCircular;
  final String? imageUrl;
  final String? placeHolderUrl;
  final double radius;
  final BoxFit boxFit;

  const CurvedImage(
      {Key? key, this.imageUrl, this.placeHolderUrl, this.radius = RadiusConstants.circularRadius,
      this.isCircular = true,this.boxFit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircular ? BorderRadius.circular(radius) :
      const BorderRadius.all(Radius.circular(RadiusConstants.smallCardRadius)),
      child: imageUrl == null
          ? NetworkingImage(loaderErrorDimension: radius, imageUrl: placeHolderUrl,boxFit: boxFit,)
          : NetworkingImage(loaderErrorDimension: radius, imageUrl: imageUrl,boxFit: boxFit),
    );
  }
}


