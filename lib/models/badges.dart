import 'dart:convert';

class Badge {
  Badge({
    this.uid,
    this.name,
    this.level,
    this.level1Photo,
    this.level2Photo,
    this.level3Photo,
    this.currentStage,
  });

  String? uid;
  String? name;
  int? level;
  String? level1Photo;
  String? level2Photo;
  String? level3Photo;
  int? currentStage;

  factory Badge.fromJson(String str) => Badge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Badge.fromMap(Map<String, dynamic> json) => Badge(
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        level: json["level"] == null ? null : json["level"],
        level1Photo: json["level1photo"] == null ? null : json["level1photo"],
        level2Photo: json["level2photo"] == null ? null : json["level2photo"],
        level3Photo: json["level3photo"] == null ? null : json["level3photo"],
        currentStage:
            json["currentStage"] == null ? null : json["currentStage"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "level": level == null ? null : level,
        "level1photo": level1Photo == null ? null : level1Photo,
        "level2photo": level2Photo == null ? null : level2Photo,
        "level3photo": level3Photo == null ? null : level3Photo,
        "currentStage": currentStage == null ? null : currentStage,
      };
}
