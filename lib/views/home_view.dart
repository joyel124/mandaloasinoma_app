import 'package:flutter/material.dart';
import 'package:mandaloasinoma_app/data/data.dart';
import 'package:mandaloasinoma_app/widgets/header_widget.dart';
import 'package:mandaloasinoma_app/widgets/most_popular_widget.dart';

import '../widgets/coming_soon_widget.dart';
import '../widgets/doujin_widget.dart';
import '../widgets/manga_widget.dart';
import '../widgets/navbar_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: const NavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 24),
              MostPopularSection(),
              SizedBox(height: 24),
              MangasSection(),
              SizedBox(height: 24),
              DoujinsSection(),
              SizedBox(height: 24),
              ComingSoonSection(),
            ],
          ),
        ),
      ),
    );
  }
}