import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:superit/widgets/post_card.dart';

import '../utils/colors.dart';
import '../utils/global_variable.dart';
import '../widgets/bookmark_card.dart';

class profileFeedScreen extends StatefulWidget {
  final String uid;
  const profileFeedScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<profileFeedScreen> createState() => _profileFeedScreenState();
}

class _profileFeedScreenState extends State<profileFeedScreen> {
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
              title:

                  Image.asset(
                'assets/logo.png',
                //color: primaryColor,
                height: 32,
              ),

            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts')
          .where('uid', isEqualTo: widget.uid)
        .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data?.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
