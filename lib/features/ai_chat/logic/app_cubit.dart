import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../core/data.dart';
import '../data/models/send_message_model.dart';
import '../data/models/text_message_model.dart';
import '../data/models/text_with_image_message_model.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial());

  static GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: AppData.apiKey,
  );
  final TextEditingController messageController = TextEditingController();
  static ScrollController scrollController = ScrollController();
  SendMessageModel sendTextMessage = SendMessageModel(
      messageModel: TextMessageModel(
    model: model,
    scrollController: scrollController,
  ));
  late SendMessageModel sendImageAndTextMessage;

  Future<void> sendMessage({File? image}) async {
    try {
      emit(const AppState.loading());
      if (image != null) {
        sendImageAndTextMessage = SendMessageModel(
          messageModel: TextWithImageMessageModel(
            model: model,
            imageFile: image,
            scrollController: scrollController,
          ),
        );
        await sendImageAndTextMessage.sendMessage(
          image: image,
          contentText: messageController.text,
        );
      } else {
        await sendTextMessage.sendMessage(contentText: messageController.text);
      }
      emit(const AppState.success());
    } catch (error) {
      emit(const AppState.fail());
    }
  }
}
