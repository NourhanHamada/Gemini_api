import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'message_model.dart';

class TextMessageModel extends MessageModel {
  final GenerativeModel model;

  TextMessageModel({
    required this.model,
    required super.scrollController,
  });

  @override
  Future<void> sendMessage({
    String? contentText,
    File? image,
  }) async {
    if (contentText != null && contentText.isNotEmpty) {
      addMessage(
        text: contentText,
        isUserMessage: true,
      );
      final content = [Content.text(contentText)];
      final response = await model.generateContent(content);
      addMessage(
        text: response.text.toString(),
      );
      debugPrint(response.text);
    }
  }
}
