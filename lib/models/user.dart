import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.email, this.password, this.name});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  String id;
  String name;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

  String email;
  String password;

  String confirmPassword;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(topMap());
  }

  Map<String, dynamic> topMap() {
    return {'name': name, 'email': email};
  }
}
