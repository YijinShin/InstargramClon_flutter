import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class createPage extends StatefulWidget {

  final FirebaseUser user;
  createPage(this.user);

  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> {
  final textEditingController = TextEditingController(); //얘는 화면이 없어지거나 하면 메모리 해제를 해야하는 객체임 그래서 밑에 dispose 함수필요있

  File _image;

  @override
  void dispose() {
    textEditingController.dispose(); //메모리 해제를 해주
    super.dispose(); //원래 하던일을
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

 Widget _buildAppBar() {
    return AppBar(
      title: Text('새 게시물'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: (){
            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('${DateTime.now().millisecondsSinceEpoch}.png'); //파일 명은 보통 시간으로 저장함
            final task = firebaseStorageRef.putFile(
              _image, StorageMetadata(contentType: 'image/png')
            );

            task.onComplete.then((value){
              var downloadUrl = value.ref.getDownloadURL();

              downloadUrl.then((uri){
                //database에 data 쓰기
                var doc = Firestore.instance.collection('post').document();// post : 컬렉션이름 , 그 밑에 문서를 하나 만들거임. 그리고 doc이라는 변수는 그 문서를 가리키는
                doc.setData({ //map을 넣는 쉬운 방법은 json형태로 넣으면됨. json 형태로 넣으면 map으로 변환되어들어. setDate는 future<void> 형태로 리턴됨 > then 사용하기 
                  'id': doc.documentID, //생성하기 전에 id 정보를 얻을 수 있음. id는 검색이나.. 그런거 하기 위해서 가지고 있는게 좋음
                  'photoUrl' : uri.toString(),// 게시물 사진
                  'contents' : textEditingController.text, //게시물 내용
                  'email' : widget.user.email, //user 정보
                  'displayName' : widget.user.displayName,//user 정보
                  'userPhotoUrl' : widget.user.photoUrl,//user 정보
                }).then((onValue){
                  Navigator.pop(context);  //이게 창 닫아주는 것 (이전 화면으로 돌아가기)
                });
             });
            });


          },

        )
      ],
    );
 }

 Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image ==null ? Text('No image') : Image.file(_image),
          TextField(
            controller: textEditingController, //위에서 객체 선언 해줘야함
            decoration: InputDecoration(hintText: "무슨 일이 일어나고 있나요?"),
          ),
        ],
      ),
    );
 }

  Future<void> _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery); //Future<File> : 미래에 file이라는 형태가 될 애라는 의
    //_image = image 이렇게는 못하는게.. 미래에 file이 되는거라서 당장은 아님 그러니까 형식이 안맞아서 못넣음 그러면 이걸 미래에 받아야함 >> 비동기로 해야
    //비동기로 하려면 await를 붙여야 하고, 그걸 붙이려면 method에 async이 붙고, 리턴을 future로 해야함
    setState(() { //왜 setstate안에서 하냐 >> 겔러리에서 이미지 선택하고 나면 그 create창에 image가 들어가고, 그 밑에 에디터가 있도록 바뀌니까.
      _image = image;
    });

  }
}


