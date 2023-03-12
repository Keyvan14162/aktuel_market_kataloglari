import 'package:aktuel_urunler_bim_a101_sok/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentFunctions {
  final String mainCollectionName = "all_comments";
  final String subCollectionName = "comments";

  addComment(
    String userName,
    String commentText,
    String profilePicUrl,
    String docName,
  ) {
    CommentModel comment = CommentModel(
      userName,
      commentText,
      profilePicUrl,
      DateTime.now(),
    );
    Map<String, dynamic> newComment = <String, dynamic>{};
    newComment["userName"] = comment.userName;
    newComment["commentText"] = comment.commentText;
    newComment["profilePicUrl"] = comment.profilePicUrl;
    newComment["date"] = comment.date;

    FirebaseFirestore.instance
        .collection(mainCollectionName)
        .doc(docName)
        .collection(subCollectionName)
        .doc(userName)
        .set(
          newComment,
          SetOptions(merge: true),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getComments(docName) {
    return FirebaseFirestore.instance
        .collection(mainCollectionName)
        .doc(docName)
        .collection(subCollectionName)
        .orderBy("date", descending: true)
        .snapshots();
  }
}
