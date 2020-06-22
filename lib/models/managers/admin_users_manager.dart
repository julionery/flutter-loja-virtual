import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/models/managers/user_manager.dart';
import 'package:lojavirtual/models/user.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.documents.map((u) => User.fromDocument(u)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
