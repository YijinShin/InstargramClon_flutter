import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instargram_clone/tabPage.dart';
import 'dart:async';




class loginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Instargram Clon',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(50.0),),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _handleSignIn().then((user){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => tabPage(user)));
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  //이거 함수 빨간줄 떴던거는 tap page에 Firebaseuser user 선언하면서 사라짐
  //로그인은 비동기식으로 이루어짐. 미래에 firebaseuser 형식으로 받겠다는 것
  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = (await _auth.signInWithCredential( //이 firebaceuser 객체는 이메일이나 프로필 정보를 가지고있음
      GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken))).user;
    return user;

  }
}
