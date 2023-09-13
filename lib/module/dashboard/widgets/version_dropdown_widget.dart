import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class VersionDropdown extends StatelessWidget {
  const VersionDropdown({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final void Function(String?) onChanged;

  static const _versions = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: FormBuilderDropdown(
        name: 'version',
        onChanged: onChanged,
        validator: (value) => null,
        items: _versions.map((version) {
          return DropdownMenuItem<String>(
            value: version,
            child: Text(version),
          );
        }).toList(),
        decoration: InputDecoration(
          label: const Text('Version'),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.black, width: .5),
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 30,
        ),
        dropdownColor: Colors.white,
      ),
    );
  }
}
