// IMPORTANT: This is a test. It won't be used in our app!

import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };
  addUser() {
    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  getUsers() async {
    await db.collection("users").get().then((event) {
  for (var doc in event.docs) {
    print("${doc.id} => ${doc.data()}");
  }
});
  }
}
