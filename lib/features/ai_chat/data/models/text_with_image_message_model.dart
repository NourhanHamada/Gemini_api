import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'message_model.dart';

class TextWithImageMessageModel extends MessageModel {
  final GenerativeModel model;
  final File? imageFile;

  TextWithImageMessageModel({
    required this.model,
    required this.imageFile,
    required super.scrollController,
  });

  @override
  Future<void> sendMessage({
    String? contentText,
    File? image,
  }) async {
    if (image != null) {
      final images = await Future.wait([
        File(imageFile!.path).readAsBytes(),
      ]);
      final imageParts = [
        DataPart('image/jpeg', images[0]),
      ];
      final content = TextPart(contentText ?? '');
      if(content.text.isNotEmpty) addMessage(text: content.text, file: image, isUserMessage: true);
     if(content.text.isEmpty) addMessage(file: image, isUserMessage: true);
      final response = await model.generateContent([
        Content.multi([content, ...imageParts])
      ]);
      addMessage(text: response.text.toString(),);
    }
  }
}
