import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final channel = IOWebSocketChannel.connect('ws://your-flask-server-url');

  void sendNotification(String message) {
    channel.sink.add(message);
  }

  Stream get notifications => channel.stream;
}
