import 'dart:convert';

class Users {
  Users(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.department,
      this.moodcoin,
      this.farkindalikRank,
      this.geziRank,
      this.sanatRank,
      this.takimCalismasiRank,
      this.volunteerRank});

  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? department;
  int? moodcoin;
  int? volunteerRank;
  int? farkindalikRank;
  int? sanatRank;
  int? geziRank;
  int? takimCalismasiRank;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        volunteerRank:
            json["volunteerRank"] == null ? null : json["volunteerRank"],
        farkindalikRank:
            json["farkindalikRank"] == null ? null : json["farkindalikRank"],
        sanatRank: json["sanatRank"] == null ? null : json["sanatRank"],
        geziRank: json["geziRank"] == null ? null : json["geziRank"],
        takimCalismasiRank: json["takimCalismasiRank"] == null
            ? null
            : json["takimCalismasiRank"],
        email: json["email"] == null ? null : json["email"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        department: json["department"] == null ? null : json["department"],
        moodcoin: json["moodcoin"] == null ? null : json["moodcoin"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "volunteerRank": volunteerRank == null ? null : volunteerRank,
        "farkindalikRank": farkindalikRank == null ? null : farkindalikRank,
        "sanatRank": sanatRank == null ? null : sanatRank,
        "geziRank": geziRank == null ? null : geziRank,
        "takimCalismasiRank":
            takimCalismasiRank == null ? null : takimCalismasiRank,
        "email": email == null ? null : email,
        "photoURL": photoUrl == null ? null : photoUrl,
        "department": department == null ? null : department,
        "moodcoin": moodcoin == null ? null : moodcoin,
      };
}
