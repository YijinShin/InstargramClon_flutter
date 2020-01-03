import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class accountPage extends StatefulWidget {

  final FirebaseUser user;
  accountPage(this.user);


  @override
  _accountPageState createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){},
        ),
      ],
    );
  }

 Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //row 안의 요소들이 전체적으로 서로간 간격을 두고 꽉 차도
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    SizedBox(
                      width:80.0,
                      height:80.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.photoUrl),
                      ),
                    ),
                    Container(
                      width: 80.0, //사실 컨테이너에도 사이즈 기능이 있어서 sizedbox 말고 컨테이너로 써도 ㄱ
                      height: 80.0,
                      alignment: Alignment.bottomRight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          SizedBox(// 파란 + 버튼 뒤에 하얀 태두리 넣으려고 그거보다 조금 더 큰 흰 버튼 넣어줌
                            width:28.0,
                            height:28.0,
                            child: FloatingActionButton(
                              onPressed: null,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width:25.0,
                            height:25.0,
                            child: FloatingActionButton(
                              onPressed: null,
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Text(widget.user.displayName,
                style: TextStyle(fontSize: 18.0)
              ),

            ],
          ),
          //Padding(padding: EdgeInsets.all(10.0)),
          Text('0\n게시물',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          //Padding(padding: EdgeInsets.all(10.0)),
          Text('0\n팔로워',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          //Padding(padding: EdgeInsets.all(10.0)),
          Text('0\n팔로잉',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      )

    );
 }
}
