import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class SendMessageField extends StatefulWidget {
  const SendMessageField({
    super.key,
    required this.onSendPressed,
    required this.onCameraPressed,
    required this.onMicPressed,
    required this.messageController,
    this.onFieldSubmitted,
    this.focusNode
  });

  final Function() onSendPressed;
  final Function() onCameraPressed;
  final Function() onMicPressed;
  final Function(String)? onFieldSubmitted;
  final TextEditingController messageController;
  final FocusNode? focusNode;

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  bool isInputEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: widget.focusNode,
            autofocus: true,
            autocorrect: false,
            textDirection:
                isInputEnglish ? TextDirection.ltr : TextDirection.rtl,
            textInputAction: TextInputAction.done,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) {
              detectLanguage(value);
            },
            onSubmitted: widget.onFieldSubmitted,
            controller: widget.messageController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(.1),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
            ),
            maxLines: 3,
            minLines: 1,
          ),
        ),
        IconButton(
          onPressed: widget.onCameraPressed,
          icon: const Icon(
            Icons.camera_alt_outlined,
            size: 20,
          ),
        ),
        // Todo: Next version b2a :D
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Icons.mic_none_rounded,
        //     size: 20,
        //   ),
        // ),
        IconButton(
          onPressed: widget.onSendPressed,
          icon: const Icon(
            Icons.send_outlined,
            color: Colors.teal,
            size: 20,
          ),
        ),
      ],
    );
  }

  void detectLanguage(String value) {
    if (value.isEmpty) return;
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) return;
    bool newInputDirection = Bidi.hasAnyLtr(trimmedValue);

    if (newInputDirection != isInputEnglish) {
      setState(() {
        isInputEnglish = newInputDirection;
      });
    }
  }

}
