import 'package:admin/module/dashboard/dash_admin_office/controller/bar_graph_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AdminOfficeVersionDropdown
    extends GetView<AdminOfficeBarGraphController> {
  const AdminOfficeVersionDropdown({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: Obx(
        () => FormBuilderDropdown(
          name: 'version',
          initialValue: controller.listVersion.length,
          onChanged: onChanged,
          validator: (value) => null,
          items: controller.listVersion.map((version) {
            return DropdownMenuItem<int>(
              value: version,
              child: Text('Version $version'),
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
      ),
    );
  }
}
