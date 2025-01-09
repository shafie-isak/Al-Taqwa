import 'package:al_taqwa/Screens/auth/login.dart';
import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlTaqwa(),
    )
  );
}


class AlTaqwa extends StatefulWidget {
  const AlTaqwa({super.key});

  @override
  State<AlTaqwa> createState() => _AlTaqwaState();
}

class _AlTaqwaState extends State<AlTaqwa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.whiteSmoke,
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: const Text("Al Taqwa", style: TextStyle(color: AppColors.lightBlue),),
      //   leading: const Icon(Icons.filter_list_rounded, color: AppColors.secondaryColor,),
      // ),
      body: LogIn(),
    );
  }
}