part of '../views/forgot_password_view.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    Key? key,
    this.textInputAction,
    required this.controller,
  }) : super(key: key);

  final TextInputAction? textInputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      name: 'email',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // onChanged: (value) => logger.i('EMAIL: $value'),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email is required';
        } else if (value.isNotEmpty) {
          final isEmailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
          ).hasMatch(value);
          return isEmailValid ? null : 'Email is badly formatted';
        }
        return null;
      },
      textInputAction: textInputAction ?? TextInputAction.next,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 18,
        ),
        hintText: 'example@email.com',
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
