import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatService {
  static const String baseUrl = 'https://api.studyconnect.com';
  late io.Socket _socket;
  final List<Function> _listeners = [];

  void connect() {
    _socket = io.io(
      baseUrl,
      io.OptionBuilder().setTransports(['websocket']).build(),
    );

    _socket.on('connect', (_) {
      print('Connected to chat server');
    });

    _socket.on('message', (data) {
      for (var listener in _listeners) {
        listener(data);
      }
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from chat server');
    });
  }

  void sendMessage(String roomId, String message) {
    _socket.emit('message', {
      'roomId': roomId,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void joinRoom(String roomId) {
    _socket.emit('joinRoom', {'roomId': roomId});
  }

  void leaveRoom(String roomId) {
    _socket.emit('leaveRoom', {'roomId': roomId});
  }

  void addListener(Function listener) {
    _listeners.add(listener);
  }

  void removeListener(Function listener) {
    _listeners.remove(listener);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
