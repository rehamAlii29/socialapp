class ChatModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? message;

  ChatModel(
      {this.senderId,
        this.reciverId,
        this.dateTime,
        this.message,
       });

  ChatModel.fromFibrebase(Map<String, dynamic> fromfirebase) {
    senderId = fromfirebase['senderId'];
    reciverId = fromfirebase['reciverId'];
    dateTime = fromfirebase['dateTime'];
    message = fromfirebase['message'];

  }

  Map<String, dynamic> tofirebase() {
    return {
      'message': message,
      'senderId': senderId,
      'reciverId': reciverId,
      'dateTime': dateTime,
      
    };
  }
}
