import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../services/web_socket_service.dart';

class HomeModel {
  final WebSocketService _webSocketService;
  final BehaviorSubject<String> _dataSubject = BehaviorSubject<String>();

  Stream<String> get dataStream => _dataSubject.stream;

  HomeModel(this._webSocketService);

  Future<void> connect() async {
    try {
      await _webSocketService.connect();

      _webSocketService.channelStream.listen((channel) {
        channel.stream.listen((data) {
          _dataSubject.add(data.toString());
        }, onError: (error) {
          print('ошибка: $error');
          _dataSubject.addError(error);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> close() async {
    await _webSocketService.close();
    await _dataSubject.close();
  }
}
