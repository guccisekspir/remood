import 'dart:convert';

class Event {
  Event(
      {this.uid,
      this.name,
      this.eventSections,
      this.location,
      this.timeStamp,
      this.organizerName,
      this.organizerUid,
      this.winnerTags,
      this.photoUrl,
      this.department,
      this.joinersID,
      this.joinersPhoto,
      this.type});

  String? uid;
  String? type;
  String? name;
  List<String>? eventSections;
  String? location;
  String? timeStamp;
  String? organizerName;
  String? organizerUid;
  List<String>? winnerTags;
  String? photoUrl;
  String? department;
  List<String>? joinersID;
  List<String>? joinersPhoto;

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        uid: json["uid"] == null ? null : json["uid"],
        type: json["type"] == null ? null : json["type"],
        joinersID: json["joinersID"] == null ? null : json["joinersID"],
        joinersPhoto:
            json["joinersPhoto"] == null ? null : json["joinersPhoto"],
        name: json["name"] == null ? null : json["name"],
        eventSections: json["event_sections"] == null
            ? null
            : List<String>.from(json["event_sections"].map((x) => x)),
        location: json["location"] == null ? null : json["location"],
        timeStamp: json["timeStamp"] == null ? null : json["timeStamp"],
        organizerName:
            json["organizerName"] == null ? null : json["organizerName"],
        organizerUid:
            json["organizerUid"] == null ? null : json["organizerUid"],
        winnerTags: json["winnerTags"] == null
            ? null
            : List<String>.from(json["winnerTags"].map((x) => x)),
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        department: json["department"] == null ? null : json["department"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "joinersID": joinersID == null ? null : joinersID,
        "joinersPhoto": joinersPhoto == null ? null : joinersPhoto,
        "event_sections": eventSections == null
            ? null
            : List<dynamic>.from(eventSections!.map((x) => x)),
        "location": location == null ? null : location,
        "timeStamp": timeStamp == null ? null : timeStamp,
        "organizerName": organizerName == null ? null : organizerName,
        "organizerUid": organizerUid == null ? null : organizerUid,
        "winnerTags": winnerTags == null
            ? null
            : List<dynamic>.from(winnerTags!.map((x) => x)),
        "photoURL": photoUrl == null ? null : photoUrl,
        "department": department == null ? null : department,
      };
}
