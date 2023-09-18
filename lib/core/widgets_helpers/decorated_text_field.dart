import 'package:flutter/material.dart';

import '../constants/radius_constants.dart';

class DecoratedTextField extends StatefulWidget {
  final String hint;
  final String prefixText;
  final TextInputType keyboard;
  bool isObscure;
  final PrefixType prefixType;
  final isPassword;
  final String value;
  final String prefixValue;
  final PrefixIcon prefixIcon;
  final VoidCallback? onPrefixIconPressed;
  final Function(String text)? textChanged;
  final bool isEmpty;
  TextStyle? textStyle;
  final SuffixIcon suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final isReadOnly;
  final enable;
  final String? validationKey;
  TextEditingController? controller;
  final String? errorText;
  int maxLength;
  int maxLines;
  bool isAutoFocus;
  Color borderColor;
  Color emptyColor;
  double marginTop, marginRight, marginLeft;
  double corner;
  double height;
  TextStyle? hintStyle;
  bool isRequired;
  String? Function(String?)? validator;

  DecoratedTextField(
      {super.key,
      this.hint = "",
      this.prefixText = "",
      this.keyboard = TextInputType.text,
      this.isObscure = false,
      this.isPassword = false,
      this.prefixType = PrefixType.None,
      this.prefixIcon = PrefixIcon.empty,
      this.maxLines = 1,
      this.value = "",
      this.onPrefixIconPressed,
      this.isAutoFocus = false,
      this.prefixValue = "",
      this.textChanged,
      this.textStyle /*= KStyle.KLargeBodyStyle*/,
      this.hintStyle /*= KStyle.KPlaceHolderPrimaryTextStyle*/,
      this.isEmpty = false,
      this.suffixIcon = SuffixIcon.empty,
      this.onSuffixIconPressed,
      this.isReadOnly = false,
      this.enable = true,
      this.controller,
      this.validationKey,
      this.maxLength = 50,
      this.marginTop = 0,
      this.marginRight = 0,
      this.marginLeft = 0,
      this.height = 80,
      this.emptyColor = KDarkColors.kPrimaryColor,
      this.corner = RadiusConstants.textFieldRadius,
      this.borderColor = KDarkColors.kPrimaryColor,
      this.errorText,
      this.isRequired = false,
      this.validator});

  @override
  _DecoratedTextFieldState createState() => _DecoratedTextFieldState();
}

class _DecoratedTextFieldState extends State<DecoratedTextField> {
  void _toggle() {
    setState(() {
      widget.isObscure = !widget.isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          validator: widget.validator,
          enableInteractiveSelection: false,
          // key: Key(widget.validationKey),
          controller: widget.controller,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          readOnly: widget.isReadOnly,
          autofocus: widget.isAutoFocus,
          maxLength: widget.maxLength,
          // initialValue: widget.value,
          style: widget.textStyle,
          onChanged: widget.textChanged,
          obscureText:
              widget.isPassword ? !widget.isObscure : widget.isObscure,
          keyboardType: widget.keyboard,
          decoration: InputDecoration(
            counterText: "",
            errorText: widget.errorText,
            //errorStyle: TextStyle(backgroundColor: Colors.transparent),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor),
              borderRadius: BorderRadius.circular(widget.corner),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor),
              borderRadius: BorderRadius.circular(widget.corner),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                  color: widget.isEmpty
                      ? widget.emptyColor
                      : widget.borderColor),
              borderRadius: BorderRadius.circular(widget.corner),
            ),
            enabled: widget.enable,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isEmpty
                      ? widget.emptyColor
                      : widget.borderColor),
              borderRadius: BorderRadius.circular(widget.corner),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isEmpty
                      ? widget.emptyColor
                      : KDarkColors.kPrimaryColor),
              borderRadius: BorderRadius.circular(widget.corner),
            ),
            // contentPadding: const EdgeInsets.symmetric(
            //     vertical: 16,
            //     horizontal: 16),
            // fillColor: KColors.KSecondaryColor,
            // filled: true,
            hintText: widget.hint,
            // hintStyle: KStyle.KPlaceHolderTextStyle,
            suffixIcon: getSuffixIcon(
                widget.suffixIcon, widget.onSuffixIconPressed ?? (){}),
            prefixIcon: SizedBox(
              child: getIcon(widget.prefixIcon),
            ),
          ),
        ),
        Visibility(
          visible: widget.isRequired,
            child: const Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
        )
      ],
    );
  }

  ButtonTheme getIcon(PrefixIcon prefixIcon) {
    //ComeBackLatter
    if (prefixIcon == PrefixIcon.email) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.email),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.name) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.perm_identity),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.username) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.person),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.password) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.password),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.web) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.public),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.phone) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.phone),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.facebook) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.facebook),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.linkedin) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.business_center),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.instagram) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.color_lens_outlined),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    } else if (prefixIcon == PrefixIcon.search) {
      return ButtonTheme(
        child: IconButton(
          icon: const Icon(Icons.search),
          onPressed: widget.onPrefixIconPressed,
        ),
      );
    }

    return ButtonTheme(child: const SizedBox());
  }

  ButtonTheme getSuffixIcon(
      SuffixIcon suffixIcon, VoidCallback onSuffixIconPressed) {
    if (suffixIcon == SuffixIcon.password) {
      return ButtonTheme(
        minWidth: 8,
        child: IconButton(
          onPressed: _toggle,
          icon:  Icon(widget.isObscure ? Icons.visibility : Icons.visibility_off),
        ),
      );
    } else if (suffixIcon == SuffixIcon.birthday) {
      return ButtonTheme(
        minWidth: 8,
        child: IconButton(
          onPressed: onSuffixIconPressed,
          icon: const Icon(Icons.calendar_month),
        ),
      );
    } else if (suffixIcon == SuffixIcon.camera) {
      return ButtonTheme(
        minWidth: 8,
        child: IconButton(
          onPressed: onSuffixIconPressed,
          icon: const Icon(Icons.camera_alt),
        ),
      );
    }

    return ButtonTheme(child: const SizedBox(width: 0,));
  }
}

enum PrefixIcon {
  email,
  password,
  username,
  name,
  phone,
  web,
  facebook,
  linkedin,
  instagram,
  search,
  empty
}

enum PrefixType { None, Icon, Text }

enum SuffixIcon { password, birthday, camera, empty }
