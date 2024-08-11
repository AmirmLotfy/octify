part of "bloc.dart";

class MessagesData {}

class MessageModel {
  late final String messageId, chatId;
  late final bool isMe;
  late final StringBuffer message;
  late final DateTime timeSent;

  MessageModel({
    required this.messageId,
    required this.chatId,
    this.isMe = false,
    required this.message,
    required this.timeSent,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json["messageId"];
    chatId = json["chatId"];
    isMe = json["isMe"];
    message = StringBuffer(json["message"]);
    timeSent = DateTime.parse(json["timeSent"]);
  }

  MessageModel copyWith({
    String? messageId,
    String? chatId,
    bool? isMe,
    StringBuffer? message,
    DateTime? timeSent,
  }) {
    return MessageModel(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      isMe: isMe ?? this.isMe,
      message: message ?? this.message,
      timeSent: timeSent ?? this.timeSent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "messageId": messageId,
      "chatId": chatId,
      "isMe": isMe,
      "message": message.toString(),
      "timeSent": timeSent.toIso8601String()
    };
  }

  @override
  bool operator ==(Object other) {
    return other is MessageModel && other.messageId == messageId;
  }

  @override
  int get hashCode => messageId.hashCode;
}

List<MessageModel> _fakeList = [];
