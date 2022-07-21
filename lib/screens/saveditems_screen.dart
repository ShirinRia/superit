import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superit/widgets/bookmark_card.dart';

import '../utils/colors.dart';
import '../utils/global_variable.dart';
import '../widgets/post_card.dart';

class saveditemsscreen extends StatefulWidget {
  final String uid;
  const saveditemsscreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<saveditemsscreen> createState() => _saveditemsscreenState();
}

class _saveditemsscreenState extends State<saveditemsscreen> {
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
              // SvgPicture.asset(
              //   'assets/superit.svg',
              //   color: primaryColor,
              //   height: 32,
              // ),
              Image.asset(
                'assets/logo.png',
               // color: primaryColor,
                height: 32,
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(
              //       Icons.message_rounded,
              //       color: primaryColor,
              //     ),
              //     onPressed: () {},
              //   ),
              // ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users') .doc(widget.uid)
            .collection('bookmarks').snapshots(),
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
              // child: bookcard(
              //   snap: snapshot.data!.docs[index].data(),
              // ),
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
