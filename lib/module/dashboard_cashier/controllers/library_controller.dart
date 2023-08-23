import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum CashierControllerStatus { initial, fetching, loaded, error }

class CashierController extends GetxController {
  static CashierController get instance => Get.find();
  final status = CashierControllerStatus.initial.obs;
  final users = <UserModel>[].obs;
  final hasReachedMax = false.obs;

  late Worker? _statusEverWorker;

  String currentState() =>
      'CashierController(status: ${status.value}, users: ${users.length}, hasReachedMax: ${hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserCashier();
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
        if (value == CashierControllerStatus.error) {
          myLogger.e(currentState);
        }
        if (value == CashierControllerStatus.fetching) {
          myLogger.i(currentState);
        }
        if (value == CashierControllerStatus.initial) {
          myLogger.i(currentState);
        }
        if (value == CashierControllerStatus.loaded) {
          myLogger.i(currentState);
        }
      },
    );
  }

  void refreshItems() {
    getUserCashier();
  }

  Future<void> getUserCashier() async {
    status.value = CashierControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsers(office: 'Cashier');
      hasReachedMax.value = false;
      status.value = CashierControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = CashierControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = CashierControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreItems() async {
    myLogger.i('GETTING MORE USER');
    // We no longer need to change to fetching status
    // to avoid the loading animation which might confuse the user
    status.value = CashierControllerStatus.initial;
    try {
      if (hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUserDocumentSnapshot(users.last.uid);
        final newItems = await UserRepository.getUsers(
            lastDocumentSnapshot: lastDocumentSnapshot, office: 'Cashier');
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          hasReachedMax.value = true;
        }
      }
      status.value = CashierControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = CashierControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = CashierControllerStatus.error;
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
