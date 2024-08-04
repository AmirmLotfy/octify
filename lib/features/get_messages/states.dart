part of 'bloc.dart';

class GetMessagesStates {}

class GetMessagesLoadingState extends GetMessagesStates {}

class GetMessagesFailedState extends GetMessagesStates {
  final String msg;
  final int? statusCode;


  GetMessagesFailedState({required this.msg, this.statusCode});
}

class GetMessagesSuccessState extends GetMessagesStates {
  final List<MessageModel> list;

  GetMessagesSuccessState({required this.list});
}