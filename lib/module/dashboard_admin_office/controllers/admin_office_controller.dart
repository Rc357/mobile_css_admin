import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum AdminOfficeControllerStatus { initial, fetching, loaded, error }

class AdminOfficeController extends GetxController {
  static AdminOfficeController get instance => Get.find();
  final status = AdminOfficeControllerStatus.initial.obs;
  final users = <UserModel>[].obs;
  final hasReachedMax = false.obs;

  late Worker? _statusEverWorker;

  String currentState() =>
      'AdminOfficeController(status: ${status.value}, users: ${users.length}, hasReachedMax: ${hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserAdminOffice();
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
        if (value == AdminOfficeControllerStatus.error) {
          myLogger.e(currentState);
        }
        if (value == AdminOfficeControllerStatus.fetching) {
          myLogger.i(currentState);
        }
        if (value == AdminOfficeControllerStatus.initial) {
          myLogger.i(currentState);
        }
        if (value == AdminOfficeControllerStatus.loaded) {
          myLogger.i(currentState);
        }
      },
    );
  }

  void refreshItems() {
    getUserAdminOffice();
  }

  Future<void> getUserAdminOffice() async {
    status.value = AdminOfficeControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsers(office: "Admin Office");
      hasReachedMax.value = false;
      status.value = AdminOfficeControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = AdminOfficeControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = AdminOfficeControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreItems() async {
    myLogger.i('GETTING MORE USER');
    // We no longer need to change to fetching status
    // to avoid the loading animation which might confuse the user
    status.value = AdminOfficeControllerStatus.initial;
    try {
      if (hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUserDocumentSnapshot(users.last.uid);
        final newItems = await UserRepository.getUsers(
            lastDocumentSnapshot: lastDocumentSnapshot,
            office: "Admin's Office");
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          hasReachedMax.value = true;
        }
      }
      status.value = AdminOfficeControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = AdminOfficeControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = AdminOfficeControllerStatus.error;
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
