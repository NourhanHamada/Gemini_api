import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class MessageModel {
  ScrollController scrollController;

  MessageModel({required this.scrollController});

  Future<void> sendMessage({
    String? contentText,
    File? image,
  });


 static List<Map<String, dynamic>> messages = [];

  void addMessage({File? file, String? text, bool isUserMessage = false,}) {
    messages.add({
      'file': file,
      'message': text,
      'isUserMessage': isUserMessage,
    });
    scrollToBottom();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}