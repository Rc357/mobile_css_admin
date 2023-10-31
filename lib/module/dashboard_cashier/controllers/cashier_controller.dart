import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/models/user_cashier_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CashierControllerStatus { initial, fetching, loaded, error }

class CashierController extends GetxController {
  static CashierController get instance => Get.find();
  final status = CashierControllerStatus.initial.obs;
  final users = <UserCashierModel>[].obs;

  final args = Get.arguments as QuestionnaireVersionModel;

  late Worker? _statusEverWorker;
  late Worker? _hasReachedMaxListener;

  final _hasReachedMax = false.obs;
  bool get hasReachedMax => _hasReachedMax.value;
  RxBool get hasReachedMaxRx => _hasReachedMax;

  final scrollController = ScrollController();

  final userCollectionName = 'userCashier';

  String currentState() =>
      'CashierController(status: ${status.value}, users: ${users.length}, hasReachedMax: ${_hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserCashier();
    _setUpHasReachedMaxListener();
    scrollController.addListener(_monitorScrolling);
    super.onInit();
  }

  @override
  void onClose() {
    _statusEverWorker?.dispose();
    _hasReachedMaxListener?.dispose();

    scrollController.dispose();
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

  void _monitorScrolling() {
    final offset = scrollController.offset;
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final outOfRange = scrollController.position.outOfRange;
    if (offset >= maxScrollExtent && !outOfRange) {
      getMoreUsers();
    }
  }

  void _setUpHasReachedMaxListener() {
    final hasReachedMaxRx = _hasReachedMax;
    _hasReachedMaxListener = ever(hasReachedMaxRx, (value) {
      if (value == true) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Already loaded all users'),
        );
        Future.delayed(Duration(seconds: 3)).then((_) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        });
      }
    });
  }

  Future<void> getUserCashier() async {
    status.value = CashierControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsersCashier(
          office: userCollectionName, version: args.questionnaireVersion);
      _hasReachedMax.value = false;
      status.value = CashierControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = CashierControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = CashierControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreUsers() async {
    myLogger.i('GETTING MORE USER');
    myLogger.i('NAME: $userCollectionName');
    myLogger.i('LAST UID: ${users.last.uid}');
    // We no longer need to change to fetching status
    // to avoid the loading animation which might confuse the user
    status.value = CashierControllerStatus.initial;
    try {
      if (_hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUsersDocumentSnapshot(
                userCollectionName, users.last.uid);
        final newItems = await UserRepository.getUsersCashier(
            lastDocumentSnapshot: lastDocumentSnapshot,
            office: userCollectionName,
            version: args.questionnaireVersion);
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          _hasReachedMax.value = true;
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
