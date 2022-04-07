class Message {
    String message;
    String? docId;
    Message({required this.message, this.docId});

    factory Message.fromJSON(Map<String, dynamic> json) {
        return Message(message: json["message"]);
    }

    Map<String, dynamic> toJSON() {
        return {
            "message": message
        };
    }

}