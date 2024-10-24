import 'dart:io';
import 'package:file_picker/file_picker.dart'; // Required for picking files
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive design
import 'package:flutter_svg/flutter_svg.dart'; // For handling SVG images
import 'package:get/get.dart'; // For navigation and dialogs
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart'; // For emoji picker
import 'package:intl/intl.dart'; // For date formatting
import 'package:krave/services/api_constants.dart';
import 'package:krave/views/base/cachnetwork_image.dart';
import 'package:krave/views/base/custom_loading.dart';
import '../../../../utils/app_colors.dart'; // App color settings
import '../../../controllers/chat_controller.dart';
import '../../../utils/app_icons.dart'; // App icon settings
import '../../../utils/app_images.dart'; // App image settings

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  ChatController chatController = Get.find<ChatController>();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  PlatformFile? _selectedFile;
  bool _isEmojiPickerVisible = false;
  final TextEditingController _messageController = TextEditingController();


  void _sendMessage(String type) {
    String message = _messageController.text.trim(); // Get input text
    if(type == "text"){
      if (message.isNotEmpty) {
        ///==========Send message==========///
        chatController.sendMessage("$message", "${data["receiverId"]}", "${data["chatId"]}");
        _messageController.clear();
      }
    }else{
      chatController.sendMessageWithImage( _selectedImage, "$message", "${data["receiverId"]}", "${data["chatId"]}");
      _messageController.clear();
      setState(() {
        _selectedImage = null;
      });
    }
  }

  var data = Get.arguments;

  @override
  void initState() {
    chatController.listenMessage("${data["chatId"]}");
    super.initState();
  }

  @override
  void dispose() {
    chatController.offSocket("${data["chatId"]}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chatController.getMessage(id: "${data["chatId"]}");
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
                  Text('Janet Doe',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500)),
                  Text('Last seen 5 minutes ago',
                      style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: 14.sp)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: SvgPicture.asset(AppIcons.iconDot, height: 20.h, width: 20.w),
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Text("View Profile",
                      style: TextStyle(color: AppColors.primaryColor))),
              PopupMenuItem(
                  value: 2,
                  child: Text("Block Profile",
                      style: TextStyle(color: AppColors.primaryColor))),
              PopupMenuItem(
                  value: 3,
                  child: Text("Delete Conversation",
                      style: TextStyle(color: AppColors.primaryColor))),
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



    Obx(()=>
             Expanded(
              child: chatController.getMessagesLoading.value
                  ? const CustomLoading()
                  : ListView.builder(
                reverse: true,
                itemCount: chatController.getMessages.length,
                itemBuilder: (context, index) {
                  var message = chatController.getMessages[index];
                  bool isSender =  data["myId"] != message.receiverId;
                  print("******************is sender ${isSender}");
                  if (message.messageType == "text") {
                    return ListTile(
                      title: Align(
                        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: isSender
                                ? AppColors.primaryColor.withOpacity(0.8)
                                : Colors.grey[300], // Different color for receiver
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                              bottomLeft: isSender ? Radius.circular(10.r) : Radius.zero,
                              bottomRight: isSender ? Radius.zero : Radius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "${message.message}",
                            style: TextStyle(
                              color: isSender ? AppColors.textColor : Colors.black, // Different text color
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (message.messageType == "image") {
                    return Align(
                      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: message.file?.length ?? 0,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: SizedBox(
                                height: 150.h, // Set a fixed height for the image
                                width: 100.w,  // Set a fixed width for the image
                                child: CustomNetworkImage(
                                  imageUrl: "${ApiConstants.imageBaseUrl}/${message.file?[index].publicFileUrl}",
                                  height: 150.h,
                                  width: 100.w,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );

                  }
                  return null;
                },
              )
             )

          ),






          if (_selectedImage != null)
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Image.file(File(_selectedImage!.path), height: 100.h),
            ),
          if (_selectedFile != null)
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Text('Selected file: ${_selectedFile!.name}',
                  style: TextStyle(color: AppColors.textColor)),
            ),
          // Input area for typing message
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Row(
              children: [
                // IconButton(
                //   icon: const Icon(Icons.attach_file),
                //   onPressed: _pickFile,
                //   color: AppColors.primaryColor,
                // ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
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
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: _toggleEmojiPicker,
                  color: AppColors.primaryColor,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: (){
                    if(_selectedImage != null){
                      _sendMessage("image");
                    }else{
                      _sendMessage("text");
                    }
                  },
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

  // Method to pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage =File(image.path);
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
  }
}
