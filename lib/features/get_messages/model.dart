part of "bloc.dart";

class MessagesData {}


class MessageModel {
  final int id;
  final bool isMe;
  final String data, date;

  MessageModel(
      {required this.id,
      required this.data,
      required this.date,
      this.isMe = false});
}

var _fakeList = [
  MessageModel(
      id: 0,
      data: "Hello1, how can we help you?",
      date: "9:47 AM",
      ),
];
