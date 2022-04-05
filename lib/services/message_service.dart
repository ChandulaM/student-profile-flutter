import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/messages.dart';

abstract class MessageRepo {
  Future addMessage({required Message message, required String studentId});
}


class MessageService extends MessageRepo {
  
  final CollectionReference _recommendationReference = FirebaseFirestore.instance.collection("recommendations");
  
  @override
  Future addMessage({required Message message, required String studentId}) async {
    // TODO: implement addMessage

    final _messageRef = _getMessageRef(studentId);

    await _messageRef.add(message);
    
  }

  Message _getMessageFromDoc(QueryDocumentSnapshot doc) {
    return Message(message: doc.get("message"),docId: doc.id);
  }

  List<Message> _getMessagesFromQuerySnapShot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map(_getMessageFromDoc).toList();
  }

  Stream<List<Message>> getMessages(String studentId) {
    return _getMessageRef(studentId).snapshots().map(_getMessagesFromQuerySnapShot);
  }

  Future deleteMessage({required String id, required String studentId}) async {
    return _getMessageRef(studentId).doc(id).delete();
  }

  CollectionReference _getMessageRef(String studentId) {
    return _recommendationReference.doc(studentId).collection("messages").withConverter<Message>(
      fromFirestore: (snapshot, options) => Message.fromJSON(snapshot.data()!),
      toFirestore: (message, _) => message.toJSON(),
    );
  }


}