import 'dart:convert';

class Users {
  Users({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.department,
    this.moodcoin,
  });

  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? department;
  int? moodcoin;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        department: json["department"] == null ? null : json["department"],
        moodcoin: json["moodcoin"] == null ? null : json["moodcoin"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "photoURL": photoUrl == null ? null : photoUrl,
        "department": department == null ? null : department,
        "moodcoin": moodcoin == null ? null : moodcoin,
      };
}
