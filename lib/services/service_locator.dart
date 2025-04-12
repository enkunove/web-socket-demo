import 'package:get_it/get_it.dart';
import 'package:webSocketProject/services/web_socket_service.dart';
import 'package:webSocketProject/view_model/home_model.dart';

void initializeApp(){
  final sl = GetIt.instance;
  sl.registerSingleton<WebSocketService>(WebSocketService());
  sl.registerSingleton<HomeModel>(HomeModel(sl()));
}