part of 'bloc.dart';

class GetMessagesEvents {}

class GetMessagesEvent extends GetMessagesEvents {}

class AppendMessageEvent extends GetMessagesEvents {
  final String data;

  AppendMessageEvent({required this.data});
}

