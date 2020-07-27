import 'package:Bookstagram/models/single_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseProvider {
  final Firestore _db = Firestore.instance;

  DatabaseProvider() {
    print('Firestore has been initialized');
  }

  Future<void> setLastLogin(String uid, Timestamp now) async {
    await _db.collection('users').document(uid).updateData(
      {'lastLogin': now},
    );
  }

  //Returning data as a future
  Future<SingleUserModel> getUser(String uid) async {
    var snap = await _db.collection('users').document(uid).get();
    return SingleUserModel.fromFirestore(snap);
  }

  //Returning document data as a stream
  Stream<SingleUserModel> streamUser(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .snapshots()
        .map((event) => SingleUserModel.fromFirestore(event));
  }

  Future<List<DocumentSnapshot>> getAllPosts() async {
    QuerySnapshot snapshot = await _db
        .collection('posts')
        .orderBy('time', descending: true)
        .getDocuments();
    print(snapshot.documents.length);
    return Future.value(snapshot.documents);
  }
}
