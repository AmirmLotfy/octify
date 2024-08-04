part of 'bloc.dart';

class SendMessageStates {}

class SendMessageLoadingState extends SendMessageStates {}

class SendMessageFailedState extends SendMessageStates {
  final String msg;
  final int? statusCode;


  SendMessageFailedState({required this.msg, this.statusCode});
}

class SendMessageSuccessState extends SendMessageStates {
  final String msg;

  SendMessageSuccessState({
    required this.msg,
  });
}


class SendImageMessageLoadingState extends SendMessageStates {}
class SendImageMessageFailedState extends SendMessageStates {
  final String msg;
  final int? statusCode;


  SendImageMessageFailedState({required this.msg, this.statusCode});
}

class SendImageMessageSuccessState extends SendMessageStates {
  final String path;
  SendImageMessageSuccessState({
    required this.path,
  });
}