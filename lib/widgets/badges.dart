import 'package:flutter/material.dart';

Widget volunteeringBadge(double size, int level) {
  String assetPath = "";
  if (level == 1) assetPath = "assets/badges/sosyal1.png";
  if (level == 2) assetPath = "assets/badges/sosyal2.png";
  if (level == 3) assetPath = "assets/badges/sosyal3.png";
  return Container(
    width: size,
    height: size,
    child: Image.asset(
      assetPath,
      fit: BoxFit.fill,
    ),
  );
}

Widget natureBadge(double size, int level) {
  String assetPath = "";
  if (level == 1) assetPath = "assets/badges/cevre1.png";
  if (level == 2) assetPath = "assets/badges/cevre2.png";
  if (level == 3) assetPath = "assets/badges/cevre3.png";
  return Container(
    width: size,
    height: size,
    child: Image.asset(
      assetPath,
      fit: BoxFit.fill,
    ),
  );
}

Widget countBadge(double size, int level) {
  String assetPath = "";
  if (level == 1) assetPath = "assets/badges/rozet1.png";
  if (level == 2) assetPath = "assets/badges/rozet2.png";
  if (level == 3) assetPath = "assets/badges/rozet3.png";
  return Container(
    width: size,
    height: size,
    child: Image.asset(
      assetPath,
      fit: BoxFit.fill,
    ),
  );
}

Widget donateBadge(double size, int level) {
  String assetPath = "";
  if (level == 1) assetPath = "assets/badges/kan1.png";
  if (level == 2) assetPath = "assets/badges/kan2.png";
  if (level == 3) assetPath = "assets/badges/kan3.png";
  return Container(
    width: size,
    height: size,
    child: Image.asset(
      assetPath,
      fit: BoxFit.fill,
    ),
  );
}
