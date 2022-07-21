import 'package:cloud_firestore/cloud_firestore.dart';

class bookmark {

  final String uid;

  final String postId;


  const bookmark(
      {
        required this.uid,

        required this.postId,

      });


  Map<String, dynamic> toJson() => {

    "uid": uid,

    "postId": postId,

  };
  static bookmark fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return bookmark(

      uid: snapshot["uid"],

      postId: snapshot["postId"],

    );
  }

}
