import 'package:flutter/material.dart';
import '../constants/radius_constants.dart';

class CustomBottomSheets {
  static showModalSheet(context, {required WidgetBuilder builder}) {
    showModalBottomSheet<void>(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(RadiusConstants.cardRadius),
              topRight: Radius.circular(RadiusConstants.cardRadius))),
      context: context,
      builder: builder
    );
  }
}
