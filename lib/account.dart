// ignore_for_file: unnecessary_this, unused_field
import 'package:firebase_database/firebase_database.dart';

class Account {
  String email;
  String password;
  DatabaseReference? _id;
  bool loggedIn = true;

  Account(this.email, this.password);

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'password': this.password,
      "loggedIn": loggedIn
    };
  }
}
