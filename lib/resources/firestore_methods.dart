import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:superit/resources/storage_methods.dart';

import 'package:uuid/uuid.dart';

import '../models/bookmark.dart';
import '../models/post.dart';
import '../models/bookmark.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage,String type) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        Type: type,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  // Post comment
  Future<void> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    // String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'likes': [],
          'postId': postId,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        //res = 'success';
      } else {
        // res = "Please enter text";
      }
    } catch (err) {
      //res = err.toString();
    }
    //return res;
  }
  //like comment
  Future<void> likecomment(String postId,String commentId, String uid, List clikes) async {
    // String res = "Some error occurred";
    print(postId);
    print(commentId);
    try {
      if (clikes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      // res = 'success';
    } catch (err) {
      print(err.toString());
    }
    //return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  Future<void> follwers(String uid, String followerId,String name, String profilePic) async {
    // String res = "Some error occurred";
    try {

      // if the likes list contains the user uid, we need to remove it
      String followId = const Uuid().v1();
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('following')
          .doc(followId)
          .set({
        'profilePic': profilePic,
        'name': name,
        'uid': uid,

        'followId': followId,
        'followerId':followerId,

      });

      await _firestore
          .collection('users')
          .doc(followerId)
          .collection('follower')
          .doc(followId)
          .set({
        'profilePic': profilePic,
        'name': name,
        'uid':followerId,

        'followId': followId,
        'followerId':uid,

      });
      //res = 'success';
      followUser(uid, followerId);
    } catch (err) {
      //res = err.toString();
    }
    //return res;
  }

  //bookmark
  // Future<String> bookmarks(String postId, String uid) async {
  //   // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
  //   String res = "Some error occurred";
  //   try {
  //
  //     // String bookmarkId = const Uuid().v1(); // creates unique id based on time
  //     String bookmarkId = const Uuid().v1();
  //     bookmark book = bookmark(
  //
  //       uid: uid,
  //
  //
  //       postId: postId,
  //
  //     );
  //     _firestore.collection('bookmarkpost').doc(bookmarkId).set(book.toJson());
  //     res = "success";
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }
  Future<String>bookmarks(String description, String file, String uid,
      String username, String profImage,String type,String postId
      ) async {
     String res = "Some error occurred";
    try {

        // if the likes list contains the user uid, we need to remove it
        String bookmarkId = const Uuid().v1();
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('bookmarks')
            .doc(bookmarkId)
            .set({
          'postId': postId,
          'description': description,
          'uid': uid,
          'username': username,
          'bookmarkId': bookmarkId,

          'datePublished': DateTime.now(),
          'postUrl':file,
          'profImage': profImage,
          'Type': type,

        });
      res="success";

    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  //delete bookmark
  Future<String> deletebookmark(String uid,String bookmarkId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('users').doc(uid)
          .collection('bookmarks').doc(bookmarkId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data() as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

