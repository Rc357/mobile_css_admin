import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/models/user_security_office_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum SecurityAdminOfficeControllerStatus { initial, fetching, loaded, error }

class SecurityAdminOfficeController extends GetxController {
  static SecurityAdminOfficeController get instance => Get.find();
  final status = SecurityAdminOfficeControllerStatus.initial.obs;
  final users = <UserSecurityOfficeModel>[].obs;
  final hasReachedMax = false.obs;

  final args = Get.arguments as QuestionnaireVersionModel;

  late Worker? _statusEverWorker;

  final userCollectionName = 'userSecurityOffice';

  String currentState() =>
      'SecurityAdminOfficeController(status: ${status.value}, users: ${users.length}, hasReachedMax: ${hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserSecurityAdminOffice();
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
        if (value == SecurityAdminOfficeControllerStatus.error) {
          myLogger.e(currentState);
        }
        if (value == SecurityAdminOfficeControllerStatus.fetching) {
          myLogger.i(currentState);
        }
        if (value == SecurityAdminOfficeControllerStatus.initial) {
          myLogger.i(currentState);
        }
        if (value == SecurityAdminOfficeControllerStatus.loaded) {
          myLogger.i(currentState);
        }
      },
    );
  }

  void refreshItems() {
    getUserSecurityAdminOffice();
  }

  Future<void> getUserSecurityAdminOffice() async {
    status.value = SecurityAdminOfficeControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsersSecurityOffice(
          office: userCollectionName, version: args.questionnaireVersion);
      hasReachedMax.value = false;
      status.value = SecurityAdminOfficeControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = SecurityAdminOfficeControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = SecurityAdminOfficeControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreItems() async {
    myLogger.i('GETTING MORE USER');
    // We no longer need to change to fetching status
    // to avoid the loading animation which might confuse the user
    status.value = SecurityAdminOfficeControllerStatus.initial;
    try {
      if (hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUserDocumentSnapshot(users.last.uid);
        final newItems = await UserRepository.getUsersSecurityOffice(
            lastDocumentSnapshot: lastDocumentSnapshot,
            office: userCollectionName,
            version: args.questionnaireVersion);
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          hasReachedMax.value = true;
        }
      }
      status.value = SecurityAdminOfficeControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = SecurityAdminOfficeControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = SecurityAdminOfficeControllerStatus.error;
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
