import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';
import 'like_animation.dart';

class CommentCard extends StatefulWidget {
  final snap;

  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLikeAnimating = false;
  int likelen = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.snap.data()['profilePic'],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: widget.snap.data()['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.limeAccent,
                            )),
                        TextSpan(
                          text: '  ${widget.snap.data()['text']}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap.data()['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Column(
            children: [
              LikeAnimation(
                isAnimating: widget.snap.data()['likes'].contains(user?.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {

                    await FireStoreMethods().likecomment(
                        widget.snap.data()['postId'],
                        widget.snap.data()['commentId'],
                        user!.uid,
                        widget.snap.data()['likes']);
                  },
                  icon: widget.snap.data()['likes'].contains(user?.uid)
                      ? const Icon(

                    Icons.thumb_up,
                    color: Colors.blue,
                  )
                      : const Icon(
                    Icons.thumb_up_alt_outlined,
                    //  color: Colors.transparent,
                  ),


                ),

              ),
              Text(
                '${widget.snap.data()['likes'].length} likes',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),



        ],
      ),
    );
  }
}
