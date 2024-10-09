import 'dart:io';
import 'package:file_picker/file_picker.dart'; // Required for picking files
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive design
import 'package:flutter_svg/flutter_svg.dart'; // For handling SVG images
import 'package:get/get.dart'; // For navigation and dialogs
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart'; // For emoji picker
import 'package:intl/intl.dart'; // For date formatting
import '../../../../utils/app_colors.dart'; // App color settings
import '../../../utils/app_icons.dart'; // App icon settings
import '../../../utils/app_images.dart'; // App image settings

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  XFile? _selectedImage; // Holds the selected image file
  PlatformFile? _selectedFile; // Holds the selected file (e.g., docs, pdfs)
  bool _isEmojiPickerVisible = false; // Controls visibility of emoji picker

  final TextEditingController _messageController = TextEditingController(); // Controller for message input

  List<String> _messages = []; // List to store chat messages

  // Method to pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  // Method to pick a file (document, pdf, etc.)
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  // Method to send a message
  void _sendMessage() {
    String message = _messageController.text.trim(); // Get input text

    if (message.isNotEmpty) {
      setState(() {
        _messages.add(message); // Add message to the list
      });
      _messageController.clear(); // Clear the input field
    }
  }

  // Dialog for image selection (camera or gallery)
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
              title: Text('Camera', style: TextStyle(color: AppColors.textColor)),
              onTap: () {
                _pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, color: AppColors.primaryColor),
              title: Text('Gallery', style: TextStyle(color: AppColors.textColor)),
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

  // Dialog to confirm blocking the account
  void _showBlockDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Block Account',
      titleStyle: TextStyle(
        color: AppColors.redColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 180.h,
        child: Column(
          children: [
            Divider(
              color: AppColors.borderColor.withOpacity(0.5),
              thickness: 1.h,
              indent: 20.w,
              endIndent: 20.w,
            ),
            Text(
              'Are you sure you want to block this Account?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textColor),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel button
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    backgroundColor: AppColors.borderColor,
                    fixedSize: Size(130.5.w, 60.h),
                  ),
                  child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                ),
                SizedBox(width: 10.w),
                // Block confirmation button
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.backgroundColor,
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: Size(130.5.w, 60.h),
                  ),
                  child: Text('Yes, Block', style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to confirm conversation deletion
  void _showDeleteDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Delete Conversation',
      titleStyle: TextStyle(
        color: AppColors.redColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 180.h,
        child: Column(
          children: [
            Divider(
              color: AppColors.borderColor.withOpacity(0.5),
              thickness: 1.h,
              indent: 20.w,
              endIndent: 20.w,
            ),
            Text(
              'Are you sure you want to delete this conversation?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textColor),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel button
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    backgroundColor: AppColors.borderColor,
                    fixedSize: Size(130.5.w, 60.h),
                  ),
                  child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
                ),
                SizedBox(width: 10.w),
                // Delete confirmation button
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.backgroundColor,
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: Size(130.5.w, 60.h),
                  ),
                  child: Text('Yes, Delete', style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Toggle emoji picker visibility
  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiPickerVisible = !_isEmojiPickerVisible;
    });
  }

  // Add selected emoji to message input
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
              Image.asset(AppImages.chatImage, width: 74.w, height: 48.h),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Janet Doe', style: TextStyle(color: AppColors.textColor, fontSize: 18.sp, fontWeight: FontWeight.w500)),
                  Text('Last seen 5 minutes ago', style: TextStyle(color: AppColors.textColor.withOpacity(0.7), fontSize: 14.sp)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: SvgPicture.asset(AppIcons.iconDot, height: 20.h, width: 20.w),
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("View Profile", style: TextStyle(color: AppColors.primaryColor))),
              PopupMenuItem(value: 2, child: Text("Block Profile", style: TextStyle(color: AppColors.primaryColor))),
              PopupMenuItem(value: 3, child: Text("Delete Conversation", style: TextStyle(color: AppColors.primaryColor))),
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
          SizedBox(width: 16.w),
        ],
      ),
      body: Column(
        children: [
          // Display messages in a list
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(color: AppColors.textColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_selectedImage != null)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.file(File(_selectedImage!.path), height: 100.h),
            ),
          if (_selectedFile != null)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Selected file: ${_selectedFile!.name}', style: TextStyle(color: AppColors.textColor)),
            ),
          // Input area for typing message
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _pickFile,
                  color: AppColors.primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _showImagePickerDialog,
                  color: AppColors.primaryColor,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined),
                  onPressed: _toggleEmojiPicker,
                  color: AppColors.primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          // Show emoji picker if visible
          if (_isEmojiPickerVisible)
            SizedBox(
              height: 250.h,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _onEmojiSelected(emoji);
                },
              ),
            ),
        ],
      ),
    );
  }
}
