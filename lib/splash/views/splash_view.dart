import 'package:admin/splash/controller/splash_controller.dart';
import 'package:admin/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: LoadingIndicator(),
        ),
      ),
    );
  }
}
