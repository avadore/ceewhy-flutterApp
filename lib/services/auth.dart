import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);

  @override
  Future<User> currentUser() async {
//    return await FirebaseAuth.instance.currentUser();
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
//    final authResult = await FirebaseAuth.instance.signInAnonymously();
    final authResult = await _firebaseAuth.signInAnonymously();
    print(authResult);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<User> signInWithGoogle() async {
  final  GoogleSignIn googleSignIn = GoogleSignIn();
  final  GoogleSignInAccount googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: "ERROR_MISSING_GOOGLE_AUTH_TOKEN",
          message: "Missing Google Auth",
        );
      }
    } else {
      throw PlatformException(
        code: "error aborted by user",
        message: "Sign in aborted by user",
      );
    }
  }
  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions
    (['public_profile'],
    );
    if (result.accessToken != null){
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      return _userFromFirebase(authResult.user);
    }
    else{
       throw PlatformException(
        code: "error aborted by user",
        message: "Sign in aborted by user",
      );
    }
  }
  @override
  Future<void> signOut() async {
//    await FirebaseAuth.instance.signOut();
    final  googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin() ;
    await facebookLogin.logOut();
     await _firebaseAuth.signOut();
  }
}

// class Auth {
//   final _firebaseAuth = FirebaseAuth.instance;

//   Future<FirebaseUser> currentUser() async {
// //    return await FirebaseAuth.instance.currentUser();
//     return await _firebaseAuth.currentUser();
//   }
//   Future<FirebaseUser> signInAnonymously() async {
// //    final authResult = await FirebaseAuth.instance.signInAnonymously();
//     final authResult = await _firebaseAuth.signInAnonymously();
//     print(authResult);
//     return authResult.user;
//   }

//   Future<void> signOut() async {
// //    await FirebaseAuth.instance.signOut();
//     await _firebaseAuth.signOut();
//   }
// }

// class User {
//   User({@required this.uid});
//   final String uid;
// }

// class Auth {
//   final _firebaseAuth = FirebaseAuth.instance;

//   User _userFromFirebase(FirebaseUser user) {
//     if (user == null) {
//       return null;
//     }
//     return User(uid: user.uid);
//   }

//   Future<User> currentUser() async {
// //    return await FirebaseAuth.instance.currentUser();
//     final user = await _firebaseAuth.currentUser();
//     return _userFromFirebase(user);
//   }

//   Future<User> signInAnonymously() async {
// //    final authResult = await FirebaseAuth.instance.signInAnonymously();
//     final authResult = await _firebaseAuth.signInAnonymously();
//     print(authResult);
//     return _userFromFirebase(authResult.user);
//   }

//   Future<void> signOut() async {
// //    await FirebaseAuth.instance.signOut();
//     await _firebaseAuth.signOut();
//   }
// }
