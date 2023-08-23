import 'package:admin/enums/admin_enum.dart';
import 'package:admin/module/add_admin/controller/create_admin_dialog_controller.dart';
import 'package:admin/module/add_admin/widgets/text_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class CustomDialog extends GetView<CreateAdminDialogController> {
  static final _admins = [
    AdminTypeEnum.LibraryAdmin,
    AdminTypeEnum.Admin,
    AdminTypeEnum.SecurityAdmin,
    AdminTypeEnum.RegistrarAdmin,
    AdminTypeEnum.CashierAdmin,
  ];

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Admin Data',
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextFieldWidget(
                label: controller.userNameLabel,
                onChanged: (value) => controller.updateUsername(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ${controller.userNameLabel} value';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              InputTextFieldWidget(
                label: controller.emailLabel,
                onChanged: (value) => controller.updateEmail(value!),
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Please enter a valid email",
              ),
              SizedBox(
                height: 15,
              ),
              FormBuilderDropdown(
                name: 'adminType',
                onChanged: (value) => controller.setAdminValue(value!),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return 'This field is required';
                  }
                  return null;
                },
                items: _admins.map((reason) {
                  return DropdownMenuItem<AdminTypeEnum>(
                    value: reason,
                    child: Text(reason.description),
                  );
                }).toList(),
                decoration: InputDecoration(
                  label: Text('Admin Type'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: Colors.blue), //<-- SEE HERE
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.blue), //<-- SEE HERE
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: Colors.red), //<-- SEE HERE
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => InputTextFieldWidget(
                  obscureText: controller.seePasswordObscure.value,
                  label: 'Password',
                  onChanged: (value) => controller.updatePassword(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ${controller.passwordLabel}';
                    } else if (value != controller.confirmPassword.value) {
                      return 'Please make sure password and confirm password is the same.';
                    }
                    return null;
                  },
                  seePassword: controller.seePasswordObscure.value
                      ? GestureDetector(
                          onTap: () => controller.updateSeePassword(),
                          child: Icon(Icons.visibility_off_outlined))
                      : GestureDetector(
                          onTap: () => controller.updateSeePassword(),
                          child: Icon(Icons.visibility_outlined)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => InputTextFieldWidget(
                  obscureText: controller.seePasswordObscure.value,
                  label: 'Confirm Password',
                  onChanged: (value) =>
                      controller.updateConfirmPassword(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ${controller.passwordLabel}';
                    } else if (value != controller.password.value) {
                      return 'Please make sure password and confirm password is the same.';
                    }
                    return null;
                  },
                  seePassword: controller.seePasswordObscure.value
                      ? GestureDetector(
                          onTap: () => controller.updateSeePassword(),
                          child: Icon(Icons.visibility_off_outlined))
                      : GestureDetector(
                          onTap: () => controller.updateSeePassword(),
                          child: Icon(Icons.visibility_outlined)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (await controller.submitAdminData()) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width * .05,
                height: 30,
                decoration: BoxDecoration(
                    color: Color(0xfff0099cb),
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text('Save',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                )),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
                width: MediaQuery.of(context).size.width * .05,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text('Close',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
