import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/models/models.dart';

final theme = ThemeModel(
  accentColor: const Color(0xffDA0037),
  backgroundColor: const Color(0xff171717),
  textColor: const Color(0xffEDEDED),
  syspnosisColor: const Color(0xffEDEDED).withOpacity(0.5),
  iconColor: const Color(0xffEDEDED).withOpacity(0.75),
);

final List<CommingSoonModel> commingSoon = [
  CommingSoonModel(
    title: 'Dice',
    image: const AssetImage(
      'assets/img/dice.png',
    ),
  ),
  CommingSoonModel(
    title: 'Sweet Home',
    image: const AssetImage(
      'assets/img/sweet.png',
    ),
  ),
  CommingSoonModel(
    title: 'Tower of God',
    image: const AssetImage(
      'assets/img/towerofgod.png',
    ),
  ),
];