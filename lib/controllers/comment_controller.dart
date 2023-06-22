import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/comment.dart';

class CommentController extends GetxController{
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async{

  }
  postComment(String commentText) async{
    try{
      if(commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore.collection('users').doc(
            authController.user.uid).get();
        var allDocs = await firestore.collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;

        Comment comment = Comment(
            username: (userDoc.data()! as dynamic)['name'],
            comment: commentText.trim(),
            datetPublished: DateTime.now(),
            likes: [],
            profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
            uid: authController.user.uid,
            id: 'Comment $len'
        );
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(
          comment.toJason(),
        );
      }
    }catch(e){
      Get.snackbar('Error While Commenting', e.toString(),);

    }
  }
}
