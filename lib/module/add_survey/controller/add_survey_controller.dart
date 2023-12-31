import 'dart:io';

import 'package:admin/enums/question_type_enum.dart';
import 'package:admin/helper/my_logger_helper.dart';
import 'package:admin/models/argument_to_pass.dart';
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

enum AddSurveyStatus { initial, loading, submitted, loaded, failed }

class AddSurveyController extends GetxController {
  static AddSurveyController get instance => Get.find();

  late Worker _statusEverWorker;

  final _status = AddSurveyStatus.initial.obs;
  final _formKey = GlobalKey<FormBuilderState>();

  final args = Get.arguments as ArgumentsToPass;

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

  final questionType = QuestionTypeEnum.unknown.obs;

  String currentState() =>
      'AddSurveyController(_status: ${_status.value}, length ${allQuestion.length}, message: ${allMessages.length}';

  @override
  void onInit() {
    super.onInit();
    MyLogger.printInfo(currentState());
    getQuestions();
    getMessages();
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
          case AddSurveyStatus.loaded:
            MyLogger.printInfo(currentState());
            break;
        }
      },
    );
  }

  void updateTypeOfQuestion(QuestionTypeEnum type) {
    questionType.value = type;
  }

  void updateQuestion(String value) {
    question.value = value;
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
      await updateQuestionnaireVersionDate();
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

  Future<void> updateQuestionnaireVersionDate() async {
    await QuestionsRepository.updateQuestionnaireVersionViaId(
        id: args.versionID, office: args.questionnaireOffice);
  }

  Future<void> _addQuestion() async {
    if (questionType.value == QuestionTypeEnum.unknown) {
      Get.snackbar(
        'Warning!',
        "Please select answer type.",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    }
    try {
      final generateQuestionId = _generateQuestionId();
      // officeName + DateTime.now().toString()

      final questionData = QuestionModel(
        id: generateQuestionId,
        question: question.value,
        questionNumber: questionNumber.value,
        type: questionType.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        yes: 0,
        no: 0,
        excellent: 0,
        verySatisfactory: 0,
        satisfactory: 0,
        fair: 0,
        poor: 0,
        version: int.parse(args.questionnaireVersion),
      );

      await QuestionsRepository.createNewQuestionAdmin(
          questionData, args.questionAdminName);

      getQuestions();
    } catch (e) {
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

  void getQuestions() async {
    _status.value = AddSurveyStatus.loading;
    try {
      allQuestion.value = await QuestionsRepository.getQuestions(
          args.questionAdminName, int.parse(args.questionnaireVersion));
      questionNumber.value = allQuestion.length + 1;
      if (questionNumber.value == 0) {
        questionNumber.value = 1;
      }
      _status.value = AddSurveyStatus.loaded;
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

    final date = DateTime.now();
    final isoDate = date.toIso8601String();
    final officeName = args.adminName;
    final messageId = officeName + isoDate;

    final messageData = ThankYouMessageModel(
      messageId: messageId,
      message: thankYouMessage.value,
      office: officeName,
      image: imageURL.value,
      version: int.parse(args.questionnaireVersion),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    MyLogger.printInfo('_addThankYouMessage : $officeName');
    try {
      await QuestionsRepository.createNewThankYouMessageAdmin(
          messageData, args.regardsAdminName);
      getMessages();
    } catch (e) {
      // Error occurred while signing up.
      print('Error: $e');
    }
  }

  void getMessages() async {
    try {
      _status.value = AddSurveyStatus.loading;
      allMessages.value = await QuestionsRepository.getMessages(
          args.regardsAdminName, int.parse(args.questionnaireVersion));
      _status.value = AddSurveyStatus.loaded;
    } catch (e) {
      print('Error: $e');
      _status.value = AddSurveyStatus.failed;
    }
  }

  void getMessagesViaId(String messageID) async {
    try {
      getMessage.value = await QuestionsRepository.getMessagesViaId(
          messageID, args.regardsAdminName);
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
      MyLogger.printError("Unable to upload image error: $e");
    }
  }
}
