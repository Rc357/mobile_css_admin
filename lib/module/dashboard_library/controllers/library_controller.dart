import 'package:admin/constants/my_logger.dart';
import 'package:admin/models/questionnaire_version_model.dart';
import 'package:admin/models/user_library_model.dart';
import 'package:admin/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LibraryControllerStatus { initial, fetching, loaded, error }

class LibraryController extends GetxController {
  static LibraryController get instance => Get.find();
  final status = LibraryControllerStatus.initial.obs;
  final users = <UserLibraryModel>[].obs;

  final args = Get.arguments as QuestionnaireVersionModel;

  late Worker? _statusEverWorker;
  late Worker? _hasReachedMaxListener;

  final _hasReachedMax = false.obs;
  bool get hasReachedMax => _hasReachedMax.value;
  RxBool get hasReachedMaxRx => _hasReachedMax;

  final scrollController = ScrollController();
  final userCollectionName = 'userLibrary';

  String currentState() =>
      'LibraryController(status: ${status.value}, users: ${users.length}, userCollectionName : $userCollectionName, hasReachedMax: ${_hasReachedMax.value})';

  @override
  void onInit() {
    _monitorFeedItemsStatus();
    getUserLibrary();
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

  Future<void> getUserLibrary() async {
    status.value = LibraryControllerStatus.fetching;
    try {
      users.value = await UserRepository.getUsersLibrary(
          office: userCollectionName, version: args.questionnaireVersion);
      _hasReachedMax.value = false;
      status.value = LibraryControllerStatus.loaded;
    } on FirebaseException catch (e) {
      status.value = LibraryControllerStatus.error;
      myLogger.e(e.message ?? e.code);
    } catch (e) {
      status.value = LibraryControllerStatus.error;
      myLogger.e(e.toString());
    }
  }

  Future<void> getMoreUsers() async {
    myLogger.i('GETTING MORE USER');
    myLogger.i('NAME: $userCollectionName');
    myLogger.i('LAST UID: ${users.last.uid}');
    status.value = LibraryControllerStatus.initial;
    try {
      if (_hasReachedMax.value == false) {
        final lastDocumentSnapshot =
            await UserRepository.getUsersDocumentSnapshot(
                userCollectionName, users.last.uid);
        final newItems = await UserRepository.getUsersLibrary(
            lastDocumentSnapshot: lastDocumentSnapshot,
            office: userCollectionName,
            version: args.questionnaireVersion);
        users.addAll(newItems);
        if (newItems.length < UserRepository.queryLimit) {
          _hasReachedMax.value = true;
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
