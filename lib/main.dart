import 'package:al_taqwa/Screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {

  runApp(
    const GetMaterialApp(
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