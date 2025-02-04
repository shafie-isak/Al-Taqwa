import 'package:al_taqwa/Screens/auth/signin.dart';
import 'package:al_taqwa/Screens/duas/dua_collection.dart';
import 'package:al_taqwa/Screens/home/drawer.dart';
import 'package:al_taqwa/Screens/reminders/Alarms.dart';
import 'package:al_taqwa/Screens/reminders/todo.dart';
import 'package:al_taqwa/Screens/tasbih/tasbih.dart';
import 'package:al_taqwa/services/notification_service.dartnotification_service.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:al_taqwa/Screens/home/home.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  tz.initializeTimeZones();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => const LogIn()),
    ],
  ));
}

class AlTaqwa extends StatefulWidget {
  const AlTaqwa({super.key});

  @override
  State<AlTaqwa> createState() => _AlTaqwaState();
}

class _AlTaqwaState extends State<AlTaqwa> {
  var _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    Alarms(),
    const ToDo(),
    TasbihCounter(),
     DuaCollection()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: const Text("Al-Taqwa",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          GestureDetector(
            onTap: () {
              // Get.off(const Prayers());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(FlutterIslamicIcons.sajadah),
            ),
          )
        ],
      ),
      drawer: MyDrawer(),
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