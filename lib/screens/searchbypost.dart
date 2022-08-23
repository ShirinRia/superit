import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import 'package:superit/screens/profile_screen.dart';
import 'package:superit/screens/searchpost.dart';

import '../utils/colors.dart';
import '../utils/global_variable.dart';
import '../widgets/post_card.dart';

class Searchbypost extends StatefulWidget {
  const Searchbypost({Key? key}) : super(key: key);

  @override
  State<Searchbypost> createState() => _SearchbypostState();
}

class _SearchbypostState extends State<Searchbypost> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  ),
                ),
              );
            },
          ),
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration:
                  const InputDecoration(labelText: 'Search for post...'),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
                print(_);
              },
            ),
          ),
        ),
        body: isShowUsers
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .where(
                      'description'.trim(),
                      isEqualTo: searchController.text.trim(),
                      // isEqualTo: searchController.text,
                    )
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      child: PostCard(
                        snap: snapshot.data?.docs[index].data(),
                      ),
                    ),
                  );
                },
              )

            // FutureBuilder(
            //         future: FirebaseFirestore.instance
            //             .collection('posts')
            //             .where(
            //               'description'.trim(),
            //               isEqualTo: searchController.text.trim(),
            //               // isEqualTo: searchController.text,
            //             )
            //             .get(),
            //         builder: (context, snapshot) {
            //           if (!snapshot.hasData) {
            //             return const Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           }
            //           // return Container();
            //           return StaggeredGridView.countBuilder(
            //             crossAxisCount: 3,
            //             itemCount: (snapshot.data! as dynamic).docs.length,
            //             itemBuilder: (context, index) => InkWell(
            //               onTap: () => Navigator.of(context).push(
            //                 MaterialPageRoute(
            //                   builder: (context) => searchpostscreen(
            //                     poid: (snapshot.data! as dynamic)
            //                         .docs[index]
            //                         .data()['postId'],
            //                   ),
            //                 ),
            //               ),
            //               child: (snapshot.data! as dynamic)
            //                           .docs[index]
            //                           .data()['Type'] ==
            //                       'video'
            //                   ? Stack(
            //                       children: [
            //                         VideoPlayer(
            //                           VideoPlayerController.network(
            //                               (snapshot.data! as dynamic).docs[index]
            //                                   ['postUrl']),
            //                         ),
            //                         IconButton(
            //                           onPressed: () {
            //                             setState(() {
            //                               // pause
            //                               if ( VideoPlayerController.network(
            //                                   (snapshot.data! as dynamic).docs[index]
            //                                   ['postUrl']).value.isPlaying) {
            //                                 VideoPlayerController.network(
            //                                     (snapshot.data! as dynamic).docs[index]
            //                                     ['postUrl']).pause();
            //                               } else {
            //                                 // play
            //                                 VideoPlayerController.network(
            //                                     (snapshot.data! as dynamic).docs[index]
            //                                     ['postUrl']).play();
            //                               }
            //                             });
            //                           },
            //                          // icon
            //                           icon: Icon(
            //                         VideoPlayerController.network(
            //                         (snapshot.data! as dynamic).docs[index]
            //                         ['postUrl']).value.isPlaying
            //                                 ? Icons.pause
            //                                 : Icons.play_arrow,
            //                           ),
            //                         ),
            //                       ],
            //                     )
            //                   : Image.network(
            //                       (snapshot.data! as dynamic).docs[index]
            //                           ['postUrl'],
            //                       fit: BoxFit.cover,
            //                     ),
            //             ),
            //             staggeredTileBuilder: (index) => MediaQuery.of(context)
            //                         .size
            //                         .width >
            //                     webScreenSize
            //                 ? StaggeredTile.count(
            //                     (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
            //                 : StaggeredTile.count(
            //                     (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
            //             mainAxisSpacing: 8.0,
            //             crossAxisSpacing: 8.0,
            //           );
            //         },
            //       )
            : Container());
  }
}
