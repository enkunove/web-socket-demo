import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:rxdart/rxdart.dart';

class WebSocketService {
  final String base = "wss://wss.coincap.io/prices";
  WebSocketChannel? _channel;

  Future<String> loadApiKey() async {
    final String jsonString = await rootBundle.loadString(
      'assets/core/api.json',
    );
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return jsonMap['API_KEY'];
  }

  Future<void> connect() async {
    try {
      final String apiKey = await loadApiKey();
      _channel = WebSocketChannel.connect(
        Uri.parse("$base?assets=bitcoin,usdc&apiKey=$apiKey"),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> close() async {
    await _channel?.sink.close();
  }

  Stream<WebSocketChannel> get channelStream => Stream.value(_channel!);
}
