import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {

  final FirebaseUser user;
  homePage(this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'instargrame_clone',
          style: TextStyle(color : Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all( 8.0 ),
      child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                      'Instargrame에 오신 것을 환영합니다.',
                       style: TextStyle( fontSize:24.0),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Text(
                      '사진과 동영상을 보려면 팔로하세요.'),
                  Padding(padding: EdgeInsets.all(16.0)),
                  SizedBox(
                    width: 260.0,
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(16.0)),
                            Text(
                                user.email,
                                style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(user.displayName),
                            Padding(padding: EdgeInsets.all(16.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width:70.0,
                                  height:70.0,
                                  child: Image.network('https://cdn.pixabay.com/photo/2011/12/14/12/13/city-11087_1280.jpg', fit:BoxFit.cover),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                                SizedBox(
                                  width:70.0,
                                  height:70.0,
                                  child: Image.network('https://cdn.pixabay.com/photo/2015/03/26/09/48/chicago-690364_1280.jpg', fit:BoxFit.cover),
                                ),
                                Padding(padding: EdgeInsets.all(1.0)),
                                SizedBox(
                                  width:70.0,
                                  height:70.0,
                                  child: Image.network('https://cdn.pixabay.com/photo/2016/05/02/09/45/japan-1366872_1280.jpg', fit:BoxFit.cover),
                                ),

                              ],
                            ),
                            Padding(padding: EdgeInsets.all(4.0)),
                            Text(
                                'Facebook 친구',
                                style: TextStyle(color: Colors.blueAccent),
                            ),
                            Padding(padding: EdgeInsets.all(4.0)),
                            RaisedButton(
                              child: Text('팔로우'),
                              textColor: Colors.white,
                              color: Colors.blueAccent,
                              onPressed: (){},
                            ),
                            Padding(padding: EdgeInsets.all(4.0)),
                          ],
                        ),
                      )
                    ),
                  ),
                ],
              )
            ),
          )

      ),
    );
  }
}
