//
//     final socialMediaPost = socialMediaPostFromMap(jsonString);

import 'dart:convert';

class SocialMediaPost {
  SocialMediaPost(
      {this.body,
      this.photoUrl,
      this.likeCount,
      this.commentCount,
      this.fromWho,
      this.ownerPhoto,
      this.whenTime});

  String? body;
  String? photoUrl;
  String? ownerPhoto;
  int? likeCount;
  String? commentCount;
  String? fromWho;
  String? whenTime;

  factory SocialMediaPost.fromJson(String str) =>
      SocialMediaPost.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialMediaPost.fromMap(Map<String, dynamic> json) => SocialMediaPost(
        body: json["body"] == null ? null : json["body"],
        ownerPhoto: json["ownerPhoto"] == null ? null : json["ownerPhoto"],
        whenTime: json["whenTime"] == null ? null : json["whenTime"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        commentCount:
            json["commentCount"] == null ? null : json["commentCount"],
        fromWho: json["fromWho"] == null ? null : json["fromWho"],
      );

  Map<String, dynamic> toMap() => {
        "body": body == null ? null : body,
        "ownerPhoto": ownerPhoto == null ? null : ownerPhoto,
        "whenTime": whenTime == null ? null : whenTime,
        "photoURL": photoUrl == null ? null : photoUrl,
        "likeCount": likeCount == null ? null : likeCount,
        "commentCount": commentCount == null ? null : commentCount,
        "fromWho": fromWho == null ? null : fromWho,
      };
}
