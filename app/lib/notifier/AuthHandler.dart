import 'package:msb/api/user_api.dart';
import 'package:msb/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHandler {
  UserModel _authHandler = UserModel();

  UserModel get getCurrentUser => _authHandler;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String _retVal = "error";
    try {
      User _firebaseUser = _auth.currentUser;
      if (_firebaseUser != null) {
        _authHandler.uid = _firebaseUser.uid;
        _authHandler.email = _firebaseUser.email;
        _authHandler.fullName = _firebaseUser.displayName;
      }
    } catch (e) {
      print(e);
    }
    return _retVal;
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _authHandler.uid = res.user.uid;
      _authHandler.email = res.user.email;

      return {"isvalid": true, "data": res.user.uid};
    } catch (err) {
      return {"isvalid": false, "data": err.message};
    }
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String fullName, String role) async {
    UserModel _user = UserModel();
    try {
      final UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = res.user.uid;
      _user.fullName = fullName;
      _user.email = res.user.email;
      _user.role = role;
      UserDatabase().createUser(_user);

      return {
        "isvalid": true,
        "data": res.user.uid,
      };
    } catch (err) {
      return {
        "isvalid": false,
        "data": err.message,
      };
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
