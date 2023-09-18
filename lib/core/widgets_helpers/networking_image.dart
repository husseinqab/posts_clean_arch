import 'package:flutter/material.dart';
import '../constants/radius_constants.dart';

class NetworkingImage extends StatelessWidget {
  const NetworkingImage({
    Key? key,
    required this.loaderErrorDimension,
    required this.imageUrl,
    this.boxFit = BoxFit.cover
  }) : super(key: key);

  final double loaderErrorDimension;
  final String? imageUrl;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
        imageUrl ?? "", loadingBuilder: (BuildContext context,
            Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return SizedBox(
        height: loaderErrorDimension * 2,
        width: loaderErrorDimension * 2,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 0.5,
            color: KDarkColors.kPrimaryColor,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      );
    }, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      /*     print(imageUrl);
          print(exception.toString());*/
      return SizedBox(
          height: loaderErrorDimension * 2,
          width: loaderErrorDimension * 2,
          child: const Center(child: Icon(Icons.image_not_supported)));
    },
        fit: boxFit,
        height: loaderErrorDimension * 2,
        width: loaderErrorDimension * 2);
  }
}
