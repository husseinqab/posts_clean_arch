import 'package:flutter/material.dart';
import 'package:posts_clean_arch/core/widgets_helpers/rounded_button.dart';

import '../constants/radius_constants.dart';

class CustomConfirmationSheet extends StatelessWidget {
  final Widget topChild;
  final String description;
  final Widget underDescriptionChild;
  final VoidCallback onConfirmed;
  final String confirmButtonTitle;
  final String otherButtonTitle;

  const CustomConfirmationSheet(
      {Key? key,
      this.topChild = const SizedBox.shrink(),
      this.underDescriptionChild = const SizedBox.shrink(),
      required this.description,
      required this.onConfirmed,
      this.confirmButtonTitle = "Ok",
      this.otherButtonTitle = "Cancel"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Wrap(
        runSpacing: 16,
        children: [
          Center(child: topChild),
          // const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: KDarkColors.kPrimaryColor,
                height: 1.5),
          ),
          // const SizedBox(height: 10),
          underDescriptionChild,
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RoundedButton(
                  // width: MediaQuery.of(context).size.width / 2,
                  title: otherButtonTitle,
                  backgroundColor: Colors.white,
                  titleColor: KDarkColors.kPrimaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RoundedButton(
                  // width: MediaQuery.of(context).size.width / 2,
                  backgroundColor: Colors.green,
                  title: confirmButtonTitle,
                  onPressed: onConfirmed,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
