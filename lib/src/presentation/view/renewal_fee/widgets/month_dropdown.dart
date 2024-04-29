import 'package:flutter/material.dart';

class MonthDropdown extends StatefulWidget {
  const MonthDropdown({super.key, required this.onSelected});
  final Function(String) onSelected;
  @override
  State<MonthDropdown> createState() => _MonthDropdownState();
}

class _MonthDropdownState extends State<MonthDropdown> {
  ValueNotifier /* String */ dropdownvalue = ValueNotifier('1');

  // List of items in our dropdown menu
  var items = [
    '1',
    '3',
    '6',
  ];
  @override
  void initState() {
    widget.onSelected(dropdownvalue.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dropdownvalue,
      builder: (context, value, child) {
        return DropdownButton<String>(
          // Initial Value
          value: dropdownvalue.value, isExpanded: true,
          alignment: Alignment.topLeft,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
              alignment: Alignment.center,
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            dropdownvalue.value = newValue!;
            widget.onSelected(dropdownvalue.value);
          },
        );
      },
    );
  }
}
