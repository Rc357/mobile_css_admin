import 'package:admin/helper/asset_path_helper.dart';
import 'package:admin/module/login/controller/login_controller.dart';
import 'package:admin/widgets/loading_overlay_widget.dart';
import 'package:admin/widgets/widget_no_internet.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Obx(
      () => !controller.checkInternetController.checkNet.value
          ? const NoInternetAccess(isFromLogin: true)
          : WillPopScope(
              onWillPop: () async => controller.isLoading ? false : true,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(children: [
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: null,
                      extendBodyBehindAppBar: true,
                      body: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Container(
                          width: double.infinity,
                          height: height,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AssetPath.loginBG),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: SafeArea(
                              child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 500,
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: SingleChildScrollView(
                                child: FormBuilder(
                                  key: controller.formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * .05,
                                      ),
                                      SvgPicture.asset(
                                        AssetPath.logoIcon,
                                        height: 200,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 400,
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    onChanged: (value) =>
                                                        controller
                                                            .updateUsername(
                                                                value),
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xFF2697FF),
                                                                width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 1.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 0.5),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 1.0),
                                                      ),
                                                      labelText: "Email",
                                                      hintText: "Enter mail",
                                                      labelStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xFF2697FF),
                                                      ),
                                                    ),
                                                    validator: (value) =>
                                                        EmailValidator.validate(
                                                                value!)
                                                            ? null
                                                            : "Please enter a valid email",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // InputTextField("User Name", "Enter user name or mail id"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 400,
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    onChanged: (value) =>
                                                        controller
                                                            .updatePassword(
                                                                value),
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xFF2697FF),
                                                                width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 1.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 0.5),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 1.0),
                                                      ),
                                                      labelText: "Password",
                                                      hintText:
                                                          "Enter password",
                                                      labelStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xFF2697FF),
                                                      ),
                                                    ),
                                                    obscureText: controller
                                                        .passIsEncrypted.value,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter password';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  right: 20,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(),
                                                    child: IconButton(
                                                      icon: controller
                                                              .passIsEncrypted
                                                              .value
                                                          ? const Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              semanticLabel:
                                                                  'Eye Icon for show or hide password',
                                                            )
                                                          : Icon(
                                                              Icons.visibility,
                                                              semanticLabel:
                                                                  'Eye Icon for show or hide password',
                                                              color: Colors.grey
                                                                  .shade400),
                                                      onPressed: () => controller
                                                          .setPassEncryption(),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // InputTextFieldPass("Password", "Enter password"),
                                      SizedBox(
                                          width: 350,
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  onPressed: null,
                                                  child: const Text(
                                                      'Reset Password?'),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 40),
                                        width: 350,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              controller.loginUser(),
                                          style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            backgroundColor: Color(0xFF2697FF),
                                          ),
                                          child: const Text(
                                            'SIGN IN',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                      )),
                  _buildLoadingOverlay(),
                ]),
              ),
            ),
    );
  }

  Obx _buildLoadingOverlay() =>
      Obx(() => LoadingOverlay(isLoading: controller.isLoading));
}
