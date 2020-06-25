import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/models/user/address.dart';

class User {
  User({this.email, this.password, this.name});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    if (document.data.containsKey('address')) {
      address =
          Address.fromMap(document.data['address'] as Map<String, dynamic>);
    }
  }

  String id;
  String name;
  String email;
  String password;

  String confirmPassword;

  bool admin = false;

  Address address;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(topMap());
  }

  Map<String, dynamic> topMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address.toMap(),
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }
}
