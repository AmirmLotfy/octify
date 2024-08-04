import 'package:kiwi/kiwi.dart';

import '../core/logic/dio_helper.dart';
import 'get_messages/bloc.dart';
import 'send_message/bloc.dart';


void initKiwi(){
  KiwiContainer container = KiwiContainer();
  container.registerSingleton((container) => DioHelper());
  container.registerFactory((container) => SendMessageBloc(container.resolve<DioHelper>()));
  container.registerFactory((container) => GetMessagesBloc(container.resolve<DioHelper>()));


}