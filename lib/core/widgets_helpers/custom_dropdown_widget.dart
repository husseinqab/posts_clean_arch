import 'package:flutter/material.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  final String dropdownValue;
  final String hint;
  final List<DropDownItem> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;


  const CustomDropDownWidget(
      {super.key, required this.dropdownValue, required this.hint, required this.items, required this.onChanged,required this.validator});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField<String>(
        validator: validator,
          hint: Center(child: Text(dropdownValue == "" ? hint : dropdownValue)),
          icon: const Icon(Icons.arrow_downward,size: 12),
          elevation: 16,
          isExpanded: true,
          selectedItemBuilder: (context) {
            return items.map((DropDownItem item) {
              return DefaultTextStyle(
                  style: const TextStyle(color: Colors.black),
                  child: Center(child: Text(item.name)));
            }).toList();
          },
          //style: KStyle.KPlaceHolderTextStyle,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((DropDownItem item) {
            return DropdownMenuItem<String>(
              value: item.value,
              child: Center(child: Text(item.name)),
            );
          }).toList(),
          decoration: buildInputDecoration()
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.4),
    //         blurRadius: 0,
    //         spreadRadius: 1,
    //         offset: const Offset(0.0, 0.6),
    //       ),
    //     ],
    //   ),
    //   child:
    // );
  }
}

class DropDownItem {
  String name;
  String value;

  DropDownItem({required this.name,required this.value});
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
    errorBorder: UnderlineInputBorder(
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
