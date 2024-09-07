import 'dart:io';

import 'message_model.dart';

class SendMessageModel {
  final MessageModel messageModel;

  SendMessageModel({
    required this.messageModel,
  });

  Future<void> sendMessage({
    String? contentText,
    File? image,
  }) {
    return messageModel.sendMessage(
      contentText: contentText,
      image: image,
    );
  }
}
