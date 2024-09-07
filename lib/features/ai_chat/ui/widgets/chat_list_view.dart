import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../logic/app_state.dart';
import 'lading_dots.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({
    super.key,
    required this.messages,
    required this.scrollController,
    this.state,
  });

  final List messages;
  final ScrollController scrollController;
  final AppState<dynamic>? state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isUserMessage = message['isUserMessage'];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: isUserMessage
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: (message['file'] != null)
                        ? const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          )
                        : const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(isUserMessage ? 0 : 16),
                        topLeft: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUserMessage ? 16 : 0),
                        topRight: const Radius.circular(16),
                      ),
                      color: isUserMessage ? Colors.teal : Colors.grey,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 2 / 3,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          (Bidi.hasAnyLtr(message['message'] ?? '')) ?
                      CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        if (message['file'] != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                message['file'],
                              ),
                            ),
                          ),
                        if (message['message'] != null)
                          Text(
                            message['message'],
                            style: TextStyle(
                              color:
                                  isUserMessage ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index == messages.length - 1 &&
                  state == const AppState<dynamic>.loading())
                const LoadingDots(),
            ],
          );
        },
        separatorBuilder: (context, i) {
          return const Padding(
            padding: EdgeInsets.only(top: 12),
          );
        },
        itemCount: messages.length,
      ),
    );
  }
}
