import 'dart:convert';

class Question {
  Question({
    this.title,
    this.fromWhoName,
    this.fromWhoPhoto,
    this.body,
    this.type,
    this.commentCount,
    this.likeCount,
  });

  String? title;
  String? fromWhoName;
  String? fromWhoPhoto;
  String? body;
  String? type;
  int? commentCount;
  int? likeCount;

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        title: json["title"] == null ? null : json["title"],
        fromWhoName: json["fromWhoName"] == null ? null : json["fromWhoName"],
        fromWhoPhoto:
            json["fromWhoPhoto"] == null ? null : json["fromWhoPhoto"],
        body: json["body"] == null ? null : json["body"],
        type: json["type"] == null ? null : json["type"],
        commentCount:
            json["commentCount"] == null ? null : json["commentCount"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "fromWhoName": fromWhoName == null ? null : fromWhoName,
        "fromWhoPhoto": fromWhoPhoto == null ? null : fromWhoPhoto,
        "body": body == null ? null : body,
        "type": type == null ? null : type,
        "commentCount": commentCount == null ? null : commentCount,
        "likeCount": likeCount == null ? null : likeCount,
      };
}
