import 'package:flutter/material.dart';

class Post {
  String postId;
  String userId;
  String imageUrl;
  String imageStorangePath;
  String caption;
  String locationString;
  double latitube;
  double longitube;
  DateTime postDateTime;

//<editor-fold desc="Data Methods">

  Post({
    required this.postId,
    required this.userId,
    required this.imageUrl,
    required this.imageStorangePath,
    required this.caption,
    required this.locationString,
    required this.latitube,
    required this.longitube,
    required this.postDateTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          userId == other.userId &&
          imageUrl == other.imageUrl &&
          imageStorangePath == other.imageStorangePath &&
          caption == other.caption &&
          locationString == other.locationString &&
          latitube == other.latitube &&
          longitube == other.longitube &&
          postDateTime == other.postDateTime);

  @override
  int get hashCode =>
      postId.hashCode ^
      userId.hashCode ^
      imageUrl.hashCode ^
      imageStorangePath.hashCode ^
      caption.hashCode ^
      locationString.hashCode ^
      latitube.hashCode ^
      longitube.hashCode ^
      postDateTime.hashCode;

  @override
  String toString() {
    return 'Post{' +
        ' postId: $postId,' +
        ' userId: $userId,' +
        ' imageUrl: $imageUrl,' +
        ' imageStorangePath: $imageStorangePath,' +
        ' caption: $caption,' +
        ' locationString: $locationString,' +
        ' latitube: $latitube,' +
        ' longitube: $longitube,' +
        ' postDateTime: $postDateTime,' +
        '}';
  }

  Post copyWith({
    String? postId,
    String? userId,
    String? imageUrl,
    String? imageStorangePath,
    String? caption,
    String? locationString,
    double? latitube,
    double? longitube,
    DateTime? postDateTime,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      imageStorangePath: imageStorangePath ?? this.imageStorangePath,
      caption: caption ?? this.caption,
      locationString: locationString ?? this.locationString,
      latitube: latitube ?? this.latitube,
      longitube: longitube ?? this.longitube,
      postDateTime: postDateTime ?? this.postDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': this.postId,
      'userId': this.userId,
      'imageUrl': this.imageUrl,
      'imageStorangePath': this.imageStorangePath,
      'caption': this.caption,
      'locationString': this.locationString,
      'latitube': this.latitube,
      'longitube': this.longitube,
      'postDateTime': this.postDateTime.toUtc().toIso8601String(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] as String,
      imageStorangePath: map['imageStorangePath'] as String,
      caption: map['caption'] as String,
      locationString: map['locationString'] as String,
      latitube: map['latitube'] as double,
      longitube: map['longitube'] as double,
      postDateTime: DateTime.parse(map['postDateTime'] as String),
    );
  }

//</editor-fold>
}
