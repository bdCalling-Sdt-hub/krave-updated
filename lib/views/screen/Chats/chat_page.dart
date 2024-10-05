import 'dart:io';
import 'package:file_picker/file_picker.dart'; // Ensure this import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart'; // Add this import
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  PlatformFile? _selectedFile;
  bool _isEmojiPickerVisible = false;

  final TextEditingController _messageController = TextEditingController();

  // List to store messages
  List<String> _messages = [];
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  void _sendMessage() {
    // Get the text from the text field
    String message = _messageController.text.trim();

    if (message.isNotEmpty) {
      // Add the message to the list
      setState(() {
        _messages.add(message);
      });
      // Clear the text field
      _messageController.clear();
    }
  }

  void _showImagePickerDialog() {
    Get.defaultDialog(
      title: 'Select Image Source',
      backgroundColor: AppColors.cardColor,
      radius: 12.r,
      barrierDismissible: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
              title:
                  Text('Camera', style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                _pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, color: AppColors.primaryColor),
              title:
                  Text('Gallery', style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBlockDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Block Account',
      titleStyle: TextStyle(
          color: AppColors.redColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold),
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: AppColors.cardColor,
      radius: 12.r,
      barrierDismissible: false,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 180.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Divider(
              color: AppColors.borderColor.withOpacity(0.5),
              thickness: 1.h,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(height: 10.h),
            Text(
              'Are you sure you want to block this Account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      backgroundColor: AppColors.borderColor,
                      fixedSize: Size(130.5.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 16.w),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.backgroundColor,
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(130.5.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 16.w),
                    ),
                    child: Text(
                      'Yes, Block',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Delete Conversation',
      titleStyle: TextStyle(
          color: AppColors.redColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold),
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: AppColors.cardColor,
      radius: 12.r,
      barrierDismissible: false,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 180.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Divider(
              color: AppColors.borderColor.withOpacity(0.5),
              thickness: 1.h,
              indent: 20.w,
              endIndent: 20.w,
            ),
            SizedBox(height: 10.h),
            Text(
              'Are you sure you want to delete this conversation?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      backgroundColor: AppColors.borderColor,
                      fixedSize: Size(130.5.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 16.w),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.backgroundColor,
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(130.5.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 18.h, horizontal: 16.w),
                    ),
                    child: Text(
                      'Yes, Delete',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiPickerVisible = !_isEmojiPickerVisible;
    });
  }

  void _onEmojiSelected(Emoji emoji) {
    _messageController.text += emoji.emoji;
    _toggleEmojiPicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.asset(
                AppImages.chatImage,
                width: 74.w,
                height: 48.h,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Janet Doe',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Last seen 5 minutes ago',
                    style: TextStyle(
                      color: AppColors.textColor.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: PopupMenuButton<int>(
              icon: Badge(
                backgroundColor: AppColors.backgroundColor,
                child: SvgPicture.asset(
                  AppIcons.iconDot,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "View Profile",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Block Profile",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text(
                    "Delete Conversation",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                    break;
                  case 2:
                    _showBlockDialog(context);
                    break;
                  case 3:
                    _showDeleteDialog(context);
                    break;
                }
              },
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Column(
        children: [
          // ===============================>sender part<===========================
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat.EEEE().format(
                              DateTime.now()), // This will display the day
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    //sender
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            AppImages.chatImage,
                            width: 74.w,
                            height: 48.h,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          width: 300.w,
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: AppColors.borderColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Amet minim mollit non deserunt ullamco est sit aliqua dolor '
                                'do amet sint. Velit officia consequat duis enim velit mollit. '
                                'Exercitation venia consequat sunt nostrud amet.cccc',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat.jm().format(DateTime.now()),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          // ===============================>Receiver part<===========================
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _ReceiverText(index),
                  ],
                );
              },
            ),
          ),
          // ===============================>Image part<===========================
          SizedBox(height: 20.h),
          if (_selectedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(_selectedImage!.path),
                width: 300.w,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
          // ===============================>File part<===========================
          SizedBox(
            height: 10.h,
          ),
          if (_selectedFile != null)
            Container(
              width: 300.w,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_file, color: Colors.grey[600]),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      _selectedFile!.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          // ===============================>emoji part<===========================
          if (_isEmojiPickerVisible)
            Positioned(
              bottom: 80.h,
              left: 0,
              right: 0,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _onEmojiSelected(emoji);
                },
              ),
            ),
        ],
      ),
      // ===============================>type message part<===========================
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        color: AppColors.cardColor,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt, color: AppColors.primaryColor),
              onPressed: () => _showImagePickerDialog(),
            ),
            IconButton(
              icon: Icon(Icons.attach_file, color: AppColors.primaryColor),
              onPressed: () => _pickFile(),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.emoji_emotions, color: AppColors.primaryColor),
              onPressed: _toggleEmojiPicker,
            ),
            IconButton(
              icon: Icon(Icons.send, color: AppColors.primaryColor),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  // ===============================>Receiver method<===========================
  Widget _ReceiverText(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //receiver
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 300.w,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      _messages[index],
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat.jm().format(DateTime.now()),
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: 40.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage(AppImages.maleImage)),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
