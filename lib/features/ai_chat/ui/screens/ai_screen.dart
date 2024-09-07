import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/show_toast.dart';
import '../../data/models/message_model.dart';
import '../../logic/app_cubit.dart';
import '../../logic/app_state.dart';
import '../widgets/chat_list_view.dart';
import '../widgets/send_message_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AisScreen extends StatefulWidget {
  const AisScreen({super.key});

  @override
  State<AisScreen> createState() => _AisScreenState();
}

class _AisScreenState extends State<AisScreen> {
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    context.read<AppCubit>().messageController.dispose();
    AppCubit.scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gemini AI'),
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if (state == const AppState<dynamic>.loading()) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {
                      image = null;
                    });
                  });
                }
                if (state == const AppState<dynamic>.fail()) {
                  showToast(
                      message: 'Something went wrong, please try again later');
                }
              },
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  focusNode.requestFocus();
                });
                debugPrint(state.toString());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatListView(
                      messages: MessageModel.messages,
                      scrollController: AppCubit.scrollController,
                      state: state,
                    ),
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: SizedBox(
                              height: 100,
                              width: 150,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      width: 150,
                                      height: 100,
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Transform.translate(
                                      offset: const Offset(7, -7),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            image = null;
                                          });
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 8,
                    ),
                    SendMessageField(
                      onFieldSubmitted: (value) {
                        context.read<AppCubit>().sendMessage(image: image);
                        context.read<AppCubit>().messageController.clear();
                      },
                      onSendPressed: () {
                        context.read<AppCubit>().sendMessage(image: image);
                        context.read<AppCubit>().messageController.clear();
                      },
                      onCameraPressed: () {
                        pickImageAlertDialog(context);
                      },
                      onMicPressed: () {},
                      messageController:
                          context.read<AppCubit>().messageController,
                      focusNode: focusNode,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  File? image;

  Future<File?> getImage(ImageSource media) async {
    try {
      final pickedFile = await picker.pickImage(source: media);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> pickImageAlertDialog(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please Choose Media To Select'),
            content: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      image = await getImage(ImageSource.gallery);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.teal,
                          )),
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.teal,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'From Gallery',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      image = await getImage(ImageSource.camera);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.teal,
                          )),
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_outlined,
                            color: Colors.teal,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'From Camera',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
