import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> searcUserInDb(auth.User firebaseUser) async {
    final query = await _db
        .collection("user")
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();
    if (query.docs.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  Future<User> getUserInfoFromDbById(String userId) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: userId).get();
    return User.fromMap(query.docs[0].data());
  }

  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final UploadTask = storageRef.putFile(imageFile);

    return UploadTask.then(
        (TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
  }

  Future<List<Post>> getPostsMineAndFollowings(String userId) async {
    // データ有無を判定
    final query = await _db.collection("posts").get();
    if (query.docs.length == 0) return [];

    var userIds = await getFollowingUserIds(userId);
    userIds.add(userId);

    final quotient = userIds.length ~/ 10;
    final remainder = userIds.length % 10;
    final numberOfChunks = (remainder == 0) ? quotient : quotient + 1;

    var userIdChunks = <List<String>>[];

    if (quotient == 0) {
      userIdChunks.add(userIds);
    } else if (quotient == 1) {
      userIdChunks.add(userIds.sublist(0, 10));
      userIdChunks.add(userIds.sublist(10, 10 + remainder));
    } else {
      for (var i = 0; i < numberOfChunks - 1; i++) {
        userIdChunks.add(userIds.sublist(i * 10, i * 10 + 10));
      }
      userIdChunks.add(userIds.sublist(
          (numberOfChunks - 1) * 10, (numberOfChunks - 1) * 10 + remainder));
    }

    var results = <Post>[];
    await Future.forEach(userIdChunks, (List<String> userIds) async {
      final tempPosts = await getPostsOfChunkedUsers(userIds);
      tempPosts.forEach((post) {
        results.add(post);
      });
    });

    print("posts: $results");
    return results;
  }

  Future<List<Post>> getPostsOfChunkedUsers(List<String> userIds) async {
    var results = <Post>[];
    await _db
        .collection("posts")
        .where("userId", whereIn: userIds)
        .orderBy("postDateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        results.add(Post.fromMap(element.data()));
      });
    });

    return results;
  }

  Future<List<String>> getFollowingUserIds(String userId) async {
    final query =
        await _db.collection("users").doc(userId).collection("following").get();
    if (query.docs.length == 0) return [];

    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["userId"]);
    });
    return userIds;
  }

  // TODO
  // Future<List<Post>> getPostsByUser(String userId) {}

}
