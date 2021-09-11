import 'package:firebase_database/firebase_database.dart';
import 'account.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference saveAccount(Account account) {
  var id = databaseReference.child('accounts/').push();
  id.set(account.toJson());
  return id;
}

Future<bool> checkPw(String email, String password) async {
  bool verified = false;
  await databaseReference.child("accounts").once().then((snapshot) {
    snapshot.value.forEach((key, value) {
      if (email.toLowerCase() == value["email"] &&
          password == value["password"]) {
        verified = true;
      }
    });
  });
  return verified;
}
