import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum LibraryControllerStatus { initial, fetching, loaded, error }

class LibraryController extends GetxController {
  static LibraryController get instance => Get.find();
  final status = LibraryControllerStatus.initial.obs;
  final users = <UserModel>[].obs;
  final hasReachedMax = false.obs;

  late Worker? _statusEverWorker;

  String currentState() =>
      'LibraryController(status: ${status.value}, users: ${users.length}, hasReachedMax: ${hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserLibrary();
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
        if (value == LibraryControllerStatus.error) {
          myLogger.e(currentState);
        }
        if (value == LibraryControllerStatus.fetching) {
          myLogger.i(currentState);
        }
        if (value == LibraryControllerStatus.initial) {
          myLogger.i(currentState);
        }
        if (value == LibraryControllerStatus.loaded) {
          myLogger.i(currentState);
        }
      },
    );
  }

  void refreshItems() {
    getUserLibrary();
  }

  Future<void> getUserLibrary() async {
    status.value = LibraryControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsers(office: 'Library');
      hasReachedMax.value = false;
      status.value = LibraryControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = LibraryControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = LibraryControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreItems() async {
    myLogger.i('GETTING MORE USER');
    // We no longer need to change to fetching status
    // to avoid the loading animation which might confuse the user
    status.value = LibraryControllerStatus.initial;
    try {
      if (hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUserDocumentSnapshot(users.last.uid);
        final newItems = await UserRepository.getUsers(
            lastDocumentSnapshot: lastDocumentSnapshot, office: 'Library');
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          hasReachedMax.value = true;
        }
      }
      status.value = LibraryControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = LibraryControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = LibraryControllerStatus.error;
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
