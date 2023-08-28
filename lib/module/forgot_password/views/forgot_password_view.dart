import 'package:admin/module/forgot_password/controllers/forgot_password_controller.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:admin/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../widgets/app_logo.dart';
part '../widgets/email_text_form_field.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: const [AppLogo()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: FormBuilder(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                const AuthHeader(text: 'forgot password'),
                                const SizedBox(height: 10),
                                const AuthSubHeader(
                                  text:
                                      'Enter your email address to get the reset password instructions',
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: EmailTextFormField(
                                    controller: controller.emailController,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  width: 350,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        controller.requestPasswordResetLink(),
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: Color(0xFF2697FF),
                                    ),
                                    child: const Text(
                                      'SEND',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                _FooterWidget(
                                  loginOnTap: () =>
                                      Get.offNamed(AppPages.LOGIN),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => LoadingOverlay(isLoading: controller.isSending),
        ),
      ],
    );
  }
}

class _FooterWidget extends StatelessWidget {
  const _FooterWidget({
    Key? key,
    required this.loginOnTap,
  }) : super(key: key);

  final VoidCallback loginOnTap;

  @override
  Widget build(BuildContext context) {
    const fontSize = 16.0;
    const fontWeight = FontWeight.w500;

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'Remember Password? ',
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: loginOnTap,
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.blue,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
