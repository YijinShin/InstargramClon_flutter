import'package:flutter/material.dart';
import 'package:instargram_clone/accountPage.dart';
import 'package:instargram_clone/homePage.dart';
import 'package:instargram_clone/searchPage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class tabPage extends StatefulWidget {

  //user 정보 받기
  final FirebaseUser user;
  tabPage(this.user);

  @override
  _tagPageState createState() => _tagPageState();
}

class _tagPageState extends State<tabPage> {

  int _selectedIndex =0;
  List _pages;



  void initState(){
    super.initState();
    _pages = [
      homePage(widget.user),
      searchPage(widget.user),
      accountPage(widget.user),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onIteamTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
            BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('search')),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('account_circle')),
          ],
      ),
    );
  }

  void _onIteamTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


