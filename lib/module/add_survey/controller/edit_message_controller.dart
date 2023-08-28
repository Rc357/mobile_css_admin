import 'dart:io';

import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/thank_you_message_model.dart';
import 'package:admin/module/add_survey/controller/add_survey_controller.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum EditMessageStatus { initial, loading, submitted, loaded, failed }

class EditMessageController extends GetxController {
  static EditMessageController get instance => Get.find();

  late Worker _statusEverWorker;

  final addSurveyController = AddSurveyController.instance;

  final _status = EditMessageStatus.initial.obs;
  final _formKey = GlobalKey<FormBuilderState>();

  final args = Get.arguments as AdminModel;

  final allMessages = <ThankYouMessageModel>[].obs;
  final initialMessage = Rxn<ThankYouMessageModel>();
  final thankYouMessage = ''.obs;

  final imageName = ''.obs;
  final imageURL = ''.obs;

  final ImagePicker _picker = ImagePicker();
  Rxn<File> selectedImage = Rxn<File>();

  EditMessageStatus get status => _status.value;
  GlobalKey<FormBuilderState> get formKey => _formKey;

  bool get isLoading => _status.value == EditMessageStatus.loading;

  String currentState() =>
      'EditMessageController(_status: ${_status.value}, message: ${allMessages.length}';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    _monitorLoginStatus();
  }

  @override
  void onClose() {
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorLoginStatus() {
    _statusEverWorker = ever(
      _status,
      (value) {
        switch (value) {
          case EditMessageStatus.failed:
            MyLogger.printError(currentState());
            break;
          case EditMessageStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case EditMessageStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case EditMessageStatus.submitted:
            MyLogger.printInfo(currentState());
            break;
          case EditMessageStatus.loaded:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void setInitialData(ThankYouMessageModel message) {
    initialMessage.value = message;
    thankYouMessage.value = initialMessage.value!.message;
    imageURL.value = initialMessage.value!.image;
  }

  void updateThankYouMessage(String message) {
    thankYouMessage.value = message;
  }

  Future<bool> submitEditThankYouMessage() async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    _status.value = EditMessageStatus.loading;

    if (!isValidationSuccessful) {
      Get.snackbar(
        'Warning!',
        "Please make sure no empty field.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      _addThankYouMessage();
      _status.value = EditMessageStatus.submitted;

      Get.snackbar(
        'Success!',
        "Message Added Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      return true;
    }
    return false;
  }

  Future<void> _addThankYouMessage() async {
    if (selectedImage.value != null) {
      await uploadImage(selectedImage.value!);
    }

    final officeName = args.adminType.description
        .replaceAll(RegExp(r'[^\w\s ]+'), "")
        .removeAllWhitespace;

    final messageData = ThankYouMessageModel(
      messageId: initialMessage.value!.messageId,
      message: thankYouMessage.value,
      office: officeName,
      image: imageURL.value,
      createdAt: initialMessage.value!.createdAt,
      updatedAt: DateTime.now(),
    );

    MyLogger.printInfo('Update Message : $officeName');
    try {
      await QuestionsRepository.updateThankYouMessageAdmin(
          messageData, 'regards' + officeName);
      addSurveyController.getMessages();
    } catch (e) {
      // Error occurred while signing up.
      print('Error: $e');
    }
  }

  Future<void> takePhoto() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
      imageName.value = pickedImage.name;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> uploadImage(File fileImage) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final isoDate = DateTime.now().toIso8601String();

    Uint8List imageData = await XFile(fileImage.path).readAsBytes();
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fileImage.path},
    );
    try {
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${isoDate + imageName.value}')
          .putData(imageData, metadata);
      imageURL.value = await snapshot.ref.getDownloadURL();
    } catch (e) {
      MyLogger.printInfo("Unable to upload image error: $e");
    }
  }
}
