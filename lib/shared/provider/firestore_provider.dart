import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_cafe/model/notification_counter.dart';
import 'package:food_cafe/resource/api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireStoreDatabaseProvider {
  FirebaseFirestore _firebaseFireStore;
  FirebaseAuth _firebaseAuth;

  var _googleSignIn = GoogleSignIn();

  FireStoreDatabaseProvider(this._firebaseFireStore, this._firebaseAuth);

  Stream<List<NotificationCounterResponse>> fetchNotificationCounter() =>
      _firebaseFireStore
          .collection(tableNameNotificationCounter)
          .snapshots()
          .map((docs) => docs.docChanges
              .map<NotificationCounterResponse>((response) =>
                  NotificationCounterResponse.fromDocumentSnapshot(response))
              .toList());

  Future<User> fetchGoogleLogin() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      var googleSignInAuthentication = await googleSignInAccount.authentication;

      var credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _firebaseAuth.signInWithCredential(credential);
      var user = authResult.user;

      if (user != null)
        return _firebaseAuth.currentUser;
      else
        return null;
    }
    return null;
  }

  Future<void> fetchGoogleLogout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
