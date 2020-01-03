import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instargram_clone/loginPage.dart';
import 'package:instargram_clone/tabPage.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData) { //로그인이 되어있으면 snapshot에 정보가 있다.
          return tabPage(snapshot.data);
        }//tabpage로 갈때 firebaseuser 넘겨주
        else{
          return loginPage(); //로그인 안되어있으면 로그인 페이지
        }
      },
    ); //streamBuilder : 데이터의 흐름에 따라 조정가능하도록 하는 것


  }
}
