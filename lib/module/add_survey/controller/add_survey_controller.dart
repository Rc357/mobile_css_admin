import 'dart:io';

import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/question_model.dart';
import 'package:admin/models/thank_you_message_model.dart';
import 'package:admin/repositories/questions_repository.dart';
import 'package:admin/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum AddSurveyStatus { initial, loading, submitted, failed }

class AddSurveyController extends GetxController {
  static AddSurveyController get instance => Get.find();

  late Worker _statusEverWorker;

  final _status = AddSurveyStatus.initial.obs;
  final _formKey = GlobalKey<FormBuilderState>();

  final args = Get.arguments as AdminModel;

  final question = ''.obs;
  final questionNumber = 1.obs;
  final excellent = 0.obs;
  final verSatisfactory = 0.obs;
  final satisfactory = 0.obs;
  final fair = 0.obs;
  final poor = 0.obs;

  final allQuestion = <QuestionModel>[].obs;
  final allMessages = <ThankYouMessageModel>[].obs;
  final getMessage = Rxn<ThankYouMessageModel>();
  final thankYouMessage = ''.obs;

  final imageName = ''.obs;
  final imageURL = ''.obs;

  final ImagePicker _picker = ImagePicker();
  Rxn<File> selectedImage = Rxn<File>();

  AddSurveyStatus get status => _status.value;
  GlobalKey<FormBuilderState> get formKey => _formKey;

  bool get isLoading => _status.value == AddSurveyStatus.loading;

  String currentState() =>
      'AddSurveyController(_status: ${_status.value}, length ${allQuestion.length}, message: ${allMessages.length}';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    _getQuestions();
    _getMessages();
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
          case AddSurveyStatus.failed:
            MyLogger.printError(currentState());
            break;
          case AddSurveyStatus.loading:
            MyLogger.printInfo(currentState());
            break;
          case AddSurveyStatus.initial:
            MyLogger.printInfo(currentState());
            break;
          case AddSurveyStatus.submitted:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void updateQuestion(String value) {
    question.value = value;
  }

  void updateExcellent(String value) {
    excellent.value = int.parse(value);
  }

  void updateVerySatisfactory(String value) {
    verSatisfactory.value = int.parse(value);
  }

  void updateSatisfactory(String value) {
    satisfactory.value = int.parse(value);
  }

  void updateFair(String value) {
    fair.value = int.parse(value);
  }

  void updatePoor(String value) {
    poor.value = int.parse(value);
  }

  void updateThankYouMessage(String message) {
    thankYouMessage.value = message;
  }

  Future<bool> submitQuestion() async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    _status.value = AddSurveyStatus.loading;

    if (!isValidationSuccessful) {
      Get.snackbar(
        'Warning!',
        "Please make sure no empty field.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      _addQuestion();
      _status.value = AddSurveyStatus.submitted;

      Get.snackbar(
        'Success!',
        "Question Added Successful",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
      return true;
    }
    return false;
  }

  Future<void> _addQuestion() async {
    try {
      final generateQuestionId = _generateQuestionId();
      // officeName + DateTime.now().toString()

      final _choice = ChoicesDetails(
        points1: excellent.value.toString(),
        rating1: 'Excellent',
        points2: verSatisfactory.value.toString(),
        rating2: 'Very Satisfactory',
        points3: satisfactory.value.toString(),
        rating3: 'Satisfactory',
        points4: fair.value.toString(),
        rating4: 'Fair',
        points5: poor.value.toString(),
        rating5: 'Poor',
      );
      final questionData = QuestionModel(
        id: generateQuestionId,
        choice: _choice,
        question: question.value,
        questionNumber: questionNumber.value,
        type: 'Five Selection',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await QuestionsRepository.createNewQuestionAdmin(
          questionData,
          'questions' +
              args.adminType.description
                  .replaceAll(RegExp(r'[^\w\s ]+'), "")
                  .removeAllWhitespace);

      _getQuestions();
    } catch (e) {
      // Error occurred while signing up.
      print('Error: $e');
    }
  }

  String _generateQuestionId() {
    const uuid = Uuid();
    final randomIdWithDashes = uuid.v1();
    final randomIdWithoutDashes =
        randomIdWithDashes.replaceAll(RegExp('[-]'), '');
    final generatedPostId = '$randomIdWithoutDashes';
    return generatedPostId;
  }

  void _getQuestions() async {
    try {
      allQuestion.value = await QuestionsRepository.getQuestions('questions' +
          args.adminType.description
              .replaceAll(RegExp(r'[^\w\s ]+'), "")
              .removeAllWhitespace);
      questionNumber.value = allQuestion.length + 1;
      if (questionNumber.value == 0) {
        questionNumber.value = 1;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> submitThankYouMessage() async {
    final isValidationSuccessful = _formKey.currentState?.validate() ?? false;
    _status.value = AddSurveyStatus.loading;

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
      _status.value = AddSurveyStatus.submitted;
      Get.back(closeOverlays: true);
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

    try {
      final date = DateTime.now();
      final isoDate = date.toIso8601String();
      final messageId = args.adminType.description + isoDate;

      final messageData = ThankYouMessageModel(
        messageId: messageId,
        message: thankYouMessage.value,
        office: args.adminType.description,
        image: imageURL.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await QuestionsRepository.createNewThankYouMessageAdmin(
          messageData, 'regards' + args.adminType.description);
      _getMessages();
    } catch (e) {
      // Error occurred while signing up.
      print('Error: $e');
    }
  }

  void _getMessages() async {
    try {
      allMessages.value = await QuestionsRepository.getMessages(
          'regards' + args.adminType.description);
    } catch (e) {
      print('Error: $e');
    }
  }

  void getMessagesViaId(String messageID) async {
    try {
      getMessage.value = await QuestionsRepository.getMessagesViaId(
          messageID, 'regards' + args.adminType.description);
      MyLogger.printInfo('GET IMAGE URL: ' + getMessage.value!.image);
      if (getMessage.value != null) {
        Get.toNamed(AppPages.PREVIEW_IMAGE);
      }
    } catch (e) {
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
