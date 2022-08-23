import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superit/screens/profilefeed.dart';
import 'package:superit/screens/signin_screen.dart';
import 'package:video_player/video_player.dart';

import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/follow_button.dart';
import 'followers.dart';
import 'following.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followingLen = 0;
  int followerLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      var followingSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('following')
          .where('uid', isEqualTo: widget.uid)
          .get();
      var followerSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('follower')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLen = postSnap.docs.length;
      followingLen = followingSnap.docs.length;
      followerLen = followerSnap.docs.length;

      userData = userSnap.data()!;
      // followers = userSnap.data()!['followers'].length;
      // following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(
                userData['username'],
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(postLen, "Posts"),
                                    InkWell(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => myfriends(
                                                  uid: widget.uid,
                                                )),
                                      ),
                                      child: buildStatColumn(
                                          followingLen, "Following  "),
                                    ),
                                    InkWell(
                                        onTap: () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      follower(
                                                        uid: widget.uid,
                                                      )),
                                            ),
                                        child: buildStatColumn(
                                            followerLen, "Followers")),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            text: 'Sign Out',
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            textColor: primaryColor,
                                            borderColor: Colors.grey,
                                            function: () async {
                                              await AuthMethods().signOut();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SigninScreen(),
                                                ),
                                              );
                                            },
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                function: () async {
                                                  await FireStoreMethods()
                                                      .deletefollower(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    userData['uid'],
                                                  );

                                                  setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                function: () async {
                                                  // await FireStoreMethods()
                                                  //     .followUser(
                                                  //   FirebaseAuth.instance
                                                  //       .currentUser!.uid,
                                                  //   userData['uid'],
                                                  //

                                                  await FireStoreMethods()
                                                      .follwers(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    userData['uid'],
                                                    userData['username'],
                                                    userData['photoUrl'],
                                                  );

                                                  setState(() {
                                                    isFollowing = true;
                                                    followers++;
                                                  });
                                                },
                                              )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          userData['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 1,
                        ),
                        child: Text(
                          userData['bio'],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        _controller = VideoPlayerController.network(
                          snap['postUrl'],
                        );
                        _initializeVideoPlayerFuture = _controller.initialize();

                        _controller.setLooping(true);
                        return snap['Type'] != 'video'
                            ? InkWell(
                                child: Container(
                                  child: Image(
                                    image: NetworkImage(snap['postUrl']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => profileFeedScreen(
                                      uid: widget.uid,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                child: Stack(
                                  children: [
                                    VideoPlayer(_controller),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // pause
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                          } else {
                                            // play
                                            _controller.play();
                                          }
                                        });
                                      },
                                      // icon
                                      icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => profileFeedScreen(
                                      uid: widget.uid,
                                    ),
                                  ),
                                ),
                              );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
