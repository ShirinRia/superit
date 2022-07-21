import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superit/providers/user_provider.dart';
import 'package:superit/models/user.dart' as model;
import '../utils/colors.dart';
import '../utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
int _page=0;
late PageController pageController;
void initState(){
  super.initState();
  pageController = PageController();
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
void navigationTapped(int page){
pageController.jumpToPage(page);
}
void onPageChanged(int page){
  setState(() {
    _page=page;
  });
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        children:
          homeScreenItems,

        controller: pageController,
        onPageChanged: onPageChanged,
      ),
        bottomNavigationBar:CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color:_page==0?primaryColor:secondaryColor),label:'',
       backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.search,color:_page==1?primaryColor:secondaryColor),label:'',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,color:_page==2?primaryColor:secondaryColor),label:'',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color:_page==3?primaryColor:secondaryColor),label:'',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle,color:_page==4?primaryColor:secondaryColor),label:'',
              backgroundColor: primaryColor),
        ],
          onTap: navigationTapped,
          currentIndex: _page,

        ),

    );
  }
}