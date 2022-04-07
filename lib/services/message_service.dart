import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_profile/models/messages.dart';

abstract class MessageRepo {
  Future addMessage({required Message message, required String recId});
}


class MessageService extends MessageRepo {
  
  final CollectionReference _recommendationReference = FirebaseFirestore.instance.collection("recommendations");
  
  @override
  Future addMessage({required Message message, required String recId}) async {
    // TODO: implement addMessage

    final _messageRef = _getMessageRef(recId);

    await _messageRef.add(message);
    
  }

  Message _getMessageFromDoc(QueryDocumentSnapshot doc) {
    return Message(message: doc.get("message"),docId: doc.id);
  }

  List<Message> _getMessagesFromQuerySnapShot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map(_getMessageFromDoc).toList();
  }

  Stream<List<Message>> getMessages(String recId) {
    return _getMessageRef(recId).snapshots().map(_getMessagesFromQuerySnapShot);
  }

  Future deleteMessage({required String id, required String recId}) async {
    return _getMessageRef(recId).doc(id).delete();
  }

  CollectionReference _getMessageRef(String recId) {
    return _recommendationReference.doc(recId).collection("messages").withConverter<Message>(
      fromFirestore: (snapshot, options) => Message.fromJSON(snapshot.data()!),
      toFirestore: (message, _) => message.toJSON(),
    );
  }


}