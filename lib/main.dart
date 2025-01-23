
import 'package:al_taqwa/Screens/reminders/Alarms.dart';
import 'package:al_taqwa/Screens/reminders/todo.dart';
import 'package:al_taqwa/Screens/tasbih/tasbih.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:al_taqwa/Screens/home/home.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  final List<Widget> _screens = [const Home(), const Alarms(), const ToDo(), TasbihCounter(), const Home()];

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: const Text("Al-Taqwa",
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          GestureDetector(
            child: const Padding(
              padding:  EdgeInsets.only(right: 12.0),
              child:  Icon(FlutterIslamicIcons.sajadah),
            ),
          )
        ],
      ),
      
      body: _screens[_selectedIndex],

      bottomNavigationBar: GNav(
          backgroundColor: const Color.fromARGB(86, 195, 226, 252),
          tabBackgroundColor: AppColors.lightBlue,
          padding: const EdgeInsets.all(13),
          tabMargin: const EdgeInsets.all(8),
          selectedIndex: _selectedIndex,
          iconSize: 22,
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
              icon: FlutterIslamicIcons.tasbih3,
              text: "Tasbih",
            ),
            GButton(
              icon: FlutterIslamicIcons.prayer,
              text: "Duas",
            ),
          ],
        ),
    );
  }
}