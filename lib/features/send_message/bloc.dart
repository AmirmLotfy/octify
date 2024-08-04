import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'events.dart';

part 'states.dart';


// todo: need send Message API with ability to take files
// todo: need get Messages API
// todo: need to listen for firebase messaging then append the messages
class SendMessageBloc extends Bloc<SendMessageEvents, SendMessageStates> {
  final DioHelper _dio;

  SendMessageBloc(this._dio) : super(SendMessageStates()) {
    on<SendMessageEvent>(_sendData);
    on<SendImageMessageEvent>(_sendImageData);
  }

  void _sendData(
    SendMessageEvent event,
    Emitter<SendMessageStates> emit,
  ) async {
    emit(SendMessageLoadingState());
    final response = await _dio.send("");
    if (response.isSuccess) {
      emit(SendMessageSuccessState(msg: response.msg));
    } else {
      emit(SendMessageFailedState(
          msg: response.msg, statusCode: response.statusCode));
    }
  }

  Future<void> _sendImageData(
      SendImageMessageEvent event, Emitter<SendMessageStates> emit) async {
    emit(SendImageMessageLoadingState());
    final response = await _dio.send("");
    if (response.isSuccess) {
      emit(SendImageMessageSuccessState(path: event.path));
    } else {
      emit(SendImageMessageFailedState(
          msg: response.msg, statusCode: response.statusCode));
    }
  }
}
