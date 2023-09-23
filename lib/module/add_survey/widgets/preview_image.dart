import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewImageWidget extends GetView<AddSurveyController> {
  const PreviewImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image(
              image: CachedNetworkImageProvider(
                  controller.getMessage.value!.image))
          // Image.network(
          //   controller.getMessage.value!.image,
          // ),
          ),
    );
  }
}
