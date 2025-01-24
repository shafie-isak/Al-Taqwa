import 'package:al_taqwa/Screens/home/drawer.dart';
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
    return const Scaffold(
      // backgroundColor: AppColors.whiteSmoke,
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: const Text("Al Taqwa", style: TextStyle(color: AppColors.lightBlue),),
      //   leading: const Icon(Icons.filter_list_rounded, color: AppColors.secondaryColor,),
      // ),
      body: SignUp(),
      
    );
  }
}



