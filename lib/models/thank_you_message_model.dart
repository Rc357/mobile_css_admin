import 'package:cloud_firestore/cloud_firestore.dart';

class ThankYouMessageModel {
  static const MESSAGE_ID = 'messageId';
  static const MESSAGE = 'message';
  static const OFFICE = 'office';
  static const IMAGE = 'image';
  static const CREATED_AT = 'created_at';
  static const UPDATED_AT = 'updated_at';

  final String messageId;
  final String message;
  final String office;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  ThankYouMessageModel({
    required this.messageId,
    required this.message,
    required this.office,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      MESSAGE_ID: messageId,
      MESSAGE: message,
      OFFICE: office,
      IMAGE: image,
      CREATED_AT: FieldValue.serverTimestamp(),
      UPDATED_AT: FieldValue.serverTimestamp(),
    };
  }

  factory ThankYouMessageModel.fromMap(Map<String, dynamic> map) {
    return ThankYouMessageModel(
      messageId: map[MESSAGE_ID] as String,
      message: map[MESSAGE] as String,
      office: map[OFFICE] as String,
      image: map[IMAGE] as String,
      createdAt: (map[CREATED_AT] as Timestamp).toDate(),
      updatedAt: (map[UPDATED_AT] as Timestamp).toDate(),
    );
  }
}
