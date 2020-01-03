import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instargram_clone/createPage.dart';


class searchPage extends StatefulWidget {

  final FirebaseUser user;
  searchPage(this.user);

  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => createPage(widget.user))
          );
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.blueAccent,
      ),

    );
  }

 Widget _buildBody() {
    return StreamBuilder(
      stream: Firestore.instance.collection('post').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(! snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        var items = snapshot.data.documents ?? []; // ?? : item 이 null이면 [] 빈 리스트가 되도록 (null이 아니게 처리하는 거임)
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //한줄에 게시물 3개
            childAspectRatio: 1.0, //게시물 비율 1:1 로 만듦
            mainAxisSpacing: 1.0,//게시물 사이에 스페이스
            crossAxisSpacing: 1.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index){
            return _buildListItem(context, items[index]);
          },
        );
      }
    );
 }

  Widget _buildListItem(context, document) { //함수 타입 생략 가능
    return Image.network(
      document['photoUrl'],
      fit: BoxFit.cover, //사이즈에 맞게 이미지 넣기
    );
  }
}
