import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/models/user_registrar_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum RegistrarControllerStatus { initial, fetching, loaded, error }

class RegistrarController extends GetxController {
  static RegistrarController get instance => Get.find();
  final status = RegistrarControllerStatus.initial.obs;
  final users = <UserRegistrarModel>[].obs;
  final hasReachedMax = false.obs;

  final args = Get.arguments as QuestionnaireVersionModel;

  late Worker? _statusEverWorker;

  final userCollectionName = 'userRegistrar';

  String currentState() =>
      'RegistrarController(status: ${status.value}, users: ${users.length}, hasReachedMax: ${hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserRegistrar();
    super.onInit();
  }

  @override
  void onClose() {
    _statusEverWorker?.dispose();
    super.onClose();
  }

  void _monitorFeedItemsStatus() {
    _statusEverWorker = ever(
      status,
      (value) {
        if (value == RegistrarControllerStatus.error) {
          myLogger.e(currentState);
        }
        if (value == RegistrarControllerStatus.fetching) {
          myLogger.i(currentState);
        }
        if (value == RegistrarControllerStatus.initial) {
          myLogger.i(currentState);
        }
        if (value == RegistrarControllerStatus.loaded) {
          myLogger.i(currentState);
        }
      },
    );
  }

  void refreshItems() {
    getUserRegistrar();
  }

  Future<void> getUserRegistrar() async {
    status.value = RegistrarControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsersRegistrar(
          office: userCollectionName, version: args.questionnaireVersion);
      hasReachedMax.value = false;
      status.value = RegistrarControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = RegistrarControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = RegistrarControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreItems() async {
    myLogger.i('GETTING MORE USER');
    // We no longer need to change to fetching status
    // to avoid the loading animation which might confuse the user
    status.value = RegistrarControllerStatus.initial;
    try {
      if (hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUserDocumentSnapshot(users.last.uid);
        final newItems = await UserRepository.getUsersRegistrar(
            lastDocumentSnapshot: lastDocumentSnapshot,
            office: userCollectionName,
            version: args.questionnaireVersion);
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          hasReachedMax.value = true;
        }
      }
      status.value = RegistrarControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = RegistrarControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = RegistrarControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  String extractInitials(String input) {
    List<String> words = input.split(' ');
    String initials = '';

    for (String word in words) {
      if (word.isNotEmpty) {
        initials += word[0];
      }
    }

    return initials;
  }
}
