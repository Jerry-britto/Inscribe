import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  
  Dropdown({super.key, required this.onSelected});
  final Function(String) onSelected;

  @override
  State<Dropdown> createState() => _DropdownState();
}

  const List<String> list = <String>['St. Xaviers', 'KC','SIES','ST. ANDREWS'];
class _DropdownState extends State<Dropdown> {

    String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        widget.onSelected(value!);

        setState(() {
          dropdownValue = value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}