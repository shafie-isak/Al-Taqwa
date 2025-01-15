import 'dart:async';

import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

 bool _loading = true;



  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _loading,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/hero_bg.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dhikr Reminder",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text("Have you dhikr today?",
                        style: TextStyle(color: AppColors.white, fontSize: 18)),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  const Expanded(
                      child: Text("Daily dhikr reminder",
                          style: TextStyle(color: Colors.grey))),
                  GestureDetector(
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(8)),
              child: const ListTile(
                title: Text("Adkar Al-Sabah",
                    style: TextStyle(color: AppColors.primaryColor)),
                subtitle: Text("10:30 PM",
                    style: TextStyle(color: Color.fromARGB(236, 7, 45, 76))),
                trailing: Icon(Icons.more_vert, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}