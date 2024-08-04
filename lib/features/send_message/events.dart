part of'bloc.dart';

class SendMessageEvents {}

class SendMessageEvent extends SendMessageEvents {}
class SendImageMessageEvent extends SendMessageEvents {
  final String path;

  SendImageMessageEvent({required this.path});
}
