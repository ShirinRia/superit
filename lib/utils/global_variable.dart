
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/saveditems_screen.dart';
import '../screens/search.dart';
import '../screens/search_screen.dart';
import '../screens/searchbypost.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
 // const SearchScreen(),
const searchdialogScreen(),

  const AddPostScreen(),
   saveditemsscreen( uid: FirebaseAuth.instance.currentUser!.uid,),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
