import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String dropdownValue;
  final String hint;
  final List<String> items;
  final void Function(String?)? onChanged;

  const CustomDropDownWidget(
      {super.key, required this.dropdownValue, required this.hint, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0.6, 0.4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        hint: Center(child: Text(dropdownValue == "" ? hint : dropdownValue)),
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        isExpanded: true,
        selectedItemBuilder: (context) {
          return items.map((String location) {
            return DefaultTextStyle(
              style: TextStyle(color: Colors.black),
                child: Center(child: Text(location)));
          }).toList();
        },
        //style: KStyle.KPlaceHolderTextStyle,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(child: Text(value)),
          );
        }).toList(),
        decoration: buildInputDecoration()
      ),
    );
  }
}

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 1,
        offset: const Offset(0.0, 0.4),
      ),
    ],
  );
}

InputDecoration buildInputDecoration() {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8), //ComeBackLatter

    fillColor: Colors.white,
    filled: true,
  );
}
