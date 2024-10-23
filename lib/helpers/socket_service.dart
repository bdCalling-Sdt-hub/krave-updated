import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketServices {

  static var token = '';

  factory SocketServices() {
    return _socketApi;
  }



  SocketServices._internal();

  static final SocketServices _socketApi = SocketServices._internal();
  static IO.Socket socket = IO.io('http://192.168.10.11:8350',
      IO.OptionBuilder().setTransports(['websocket']).build());




  static void init() async{
    print("-------------------------------------------------------------------------------------------Socket call");
    if (!socket.connected) {
      socket.onConnect((_) {
        print('========> socket connected: ${socket.connected}');
      });

      socket.onConnectError((err) {
        print('========> socket connect error: $err');
      });

      socket.onDisconnect((_) {
        print('========> socket disconnected');
      });
    } else {
      print("=======> socket already connected");
    }
  }

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();
    socket.emitWithAck(event, body, ack: (data) {
      if (data != null) {
        completer.complete(data);
      } else {
        completer.complete(1);
      }
    });
    return completer.future;
  }


  static emit(String event, dynamic body) {
    if (body != null) {
      socket.emit(event, body);
      print('===========> Emit $event and \n $body');
    }
  }
}