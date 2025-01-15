import 'dart:async';
import 'package:al_taqwa/Screens/reminders/Alarms.dart';
import 'package:al_taqwa/Screens/reminders/todo.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:al_taqwa/Screens/auth/signup.dart';
import 'package:al_taqwa/Screens/home/home.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:solar_icons/solar_icons.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: AlTaqwa(),
  ));
}

class AlTaqwa extends StatefulWidget {
  const AlTaqwa({super.key});

  @override
  State<AlTaqwa> createState() => _AlTaqwaState();
}

class _AlTaqwaState extends State<AlTaqwa> with SingleTickerProviderStateMixin {
  var _selectedIndex = 0;

  final List<Widget> _screens = [const Home(), const Alarms(), const ToDo()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Al-Taqwa",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
        actions: [
          GestureDetector(
            child: const Icon(SolarIconsOutline.infoSquare),
          )
        ],
      ),
      drawer: Drawer(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
        width: 250,
        child: ListView(
          children: const [],
        ),
      ),
      body: _screens[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingActionButton.small(
        onPressed: null,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.lightBlue,
        shape: CircleBorder(
          side: BorderSide(),
        ),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottomNavigationBar: Container(
        // color: const Color.fromARGB(122, 195, 226, 252),
        height: 75,
        alignment: const Alignment(1, 1),
        child: GNav(
          backgroundColor: const Color.fromARGB(122, 195, 226, 252),
          tabBackgroundColor: AppColors.lightBlue,
          padding: const EdgeInsets.all(13),
          tabMargin: const EdgeInsets.all(8),
          selectedIndex: _selectedIndex,
          iconSize: 20,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          gap: 10,
          tabs: const [
            GButton(
              icon: SolarIconsOutline.home,
              text: 'Home',
            ),
            GButton(
              icon: SolarIconsOutline.alarm,
              text: 'Alarms',
            ),
            GButton(
              icon: SolarIconsOutline.checkSquare,
              text: 'To-do',
            ),
            GButton(
              icon: SolarIconsOutline.moonStars,
            ),
            GButton(
              icon: SolarIconsBold.library,
              text: "Adhkar",
            ),
          ],
        ),
      ),
    );
  }
}
