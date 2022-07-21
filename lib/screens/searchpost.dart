import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superit/widgets/bookmark_card.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/global_variable.dart';
import '../widgets/post_card.dart';

class searchpostscreen extends StatefulWidget {
  final String poid;

  const searchpostscreen({Key? key, required this.poid}) : super(key: key);

  @override
  State<searchpostscreen> createState() => _searchpostscreenState();
}

class _searchpostscreenState extends State<searchpostscreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,

              title: Image.asset(
                'assets/logo.png',
                // color: primaryColor,
                height: 32,
              ),
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('postId', isEqualTo: widget.poid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child:  PostCard(
                snap: snapshot.data?.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
