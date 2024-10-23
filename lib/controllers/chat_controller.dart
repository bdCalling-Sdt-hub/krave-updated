import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/route.dart';
import '../helpers/socket_service.dart';
import '../helpers/toast.dart';
import '../models/chat_user_list_model.dart';
import '../models/message_model.dart';
import '../models/profile_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constants.dart';

class ChatController extends GetxController {

  RxBool chatUserLoading = false.obs;
  RxList<ChatUserListModel> chatUsers = <ChatUserListModel>[].obs;
  getChatUser() async {
    var userId = await PrefsHelper.getString(AppConstants.userId);
    chatUserLoading(true);
    var response = await ApiClient.getData(ApiConstants.getChatUser("$userId"));
    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200) {
      chatUsers.value =  List<ChatUserListModel>.from(response.body["data"]['conversations'].map((x)=> ChatUserListModel.fromJson(x)));
      chatUserLoading(false);
    } else if (response.statusCode == 404) {
      chatUserLoading(false);
    }
  }




  ///===============Create Chat================<>
  RxBool createChatLoading = false.obs;
  createChat({
    String? conversationId,
    String? receiverId,
    String? message,
    String? messageType,
  }) async {
    createChatLoading(true);
    String userId = await PrefsHelper.getString(AppConstants.userId);
    var body = {
      "conversationId" : "$conversationId",
      "senderId": "$userId",
      "receiverId": "$receiverId",
      "message": "$message",
      "messageType" : "text"
    };
    var response = await ApiClient.postData(ApiConstants.createChat, jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      createChatLoading(false);
    }else{
      createChatLoading(false);
    }
  }



  ///*****************************message send received part****************************///


  ///****************************************************************************///
  RxList<MessageModel> getMessages = <MessageModel>[].obs;
  void listenMessage(String chatId) async {
    try {
      SocketServices.socket.on("lastMessage::$chatId", (data) {
        print("=========> Response Message: $data -------------------------");
        if (data != null) {
          MessageModel demoData = MessageModel.fromJson(data);
          // print("---------------demoData: ${demoData.senderId} \n ${demoData.runtimeType}");
          getMessages.insert(0, demoData);
          update();
          print('Message added to chatMessages list');
        } else {
          print("No message data found in the response");
        }
      });
    } catch (e, s) {
      print("Error: $e");
      print("Stack Trace: $s");
    }
  }

  offSocket(String chatId) {
    SocketServices.socket.off("lastMessage::$chatId");
    debugPrint("Socket off New message");
  }


  // Send a message
  void sendMessage(String message, String receiverId, String senderId, String chatId) {
    final body = {
      "message": "$message",
      "receiverId": "$receiverId",
      "senderId": "$senderId",
      "chatId": "$chatId",
    };
    SocketServices.emit('send-message', body);
  }


  ///===========Get messages============>
  RxBool getMessagesLoading = false.obs;
  RxString demoId = ''.obs;
  getMessage({String id = ''}) async {
    demoId.value = id;
    getMessagesLoading(true);
    var response = await ApiClient.getData(ApiConstants.getChats(id));
    if (response.statusCode == 200) {
      getMessages.value = List<MessageModel>.from(response.body["data"].map((x) => MessageModel.fromJson(x)));
      getMessagesLoading(false);
    } else {
      getMessagesLoading(false);
    }
  }

  sendMessageWithImage(File? image, String receiverId)async{
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody =
    image == null ? [] : [MultipartBody("image", image)];
    var body = {
      'messageType' : 'image',
      'message' : 'image',
      'receiverId' : '$receiverId',
      // 'chatId' : '$chatId',
    };
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var response = await ApiClient.postMultipartData(
        ApiConstants.createChat, body,
        multipartBody: multipartBody, headers: headers);
    if(response.statusCode == 200 || response.statusCode == 201){
      getMessage(id: demoId.value);
      getMessages.value;
      update();
      print("=================message send successful");
    }else{
    }
  }


}
