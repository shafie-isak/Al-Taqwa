import 'package:al_taqwa/colors.dart';
import 'package:al_taqwa/controllers/tasbihController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasbihCounter extends StatelessWidget {
  TasbihCounter({super.key});

  final Tasbihcontroller counterController = Get.put(Tasbihcontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(      
              image: DecorationImage(
                  image: AssetImage("assets/images/tasbeeh_app_bg.jpg"),
                  fit: BoxFit.cover
                  )
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Tasbeeh Counter", style: TextStyle(color:AppColors.white, fontSize: 28, fontWeight: FontWeight.bold),),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(      
                        image: DecorationImage(
                          image: AssetImage("assets/images/tasbeeh_counter.png"),
                          fit: BoxFit.fill
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 138,
                          height: 52,
                          alignment: const Alignment(1, 0),
                          margin: const EdgeInsets.only(top: 72, left: 1),
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF99A49C),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Obx(() => Text( '${counterController.counter}', style: const TextStyle(fontSize: 45, fontFamily: "Technology-Bold")) ,),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 35, left: 95),
                            width: 20,
                            height: 20,
                            alignment: const Alignment(0, 0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [ Colors.white70, Colors.black12 ], 
                                begin: Alignment.topLeft, 
                                end: Alignment.bottomRight,),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: counterController.resetCounter, 
                                  child: null,
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.white70, 
                                    foregroundColor: Colors.black45,
                                  ),
                                  ),
                            ),
                          ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [ Colors.white70, Colors.black12 ],// Gradient colors
                                begin: Alignment.topLeft,             // Start point
                                end: Alignment.bottomRight,),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: counterController.incrementCounter, 
                                child: null,
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(26),
                                  backgroundColor: Colors.white70, 
                                  foregroundColor: Colors.black45,
                                  
                                ),
                                
                                ),
                            )

                          ),
                      ],
                    )
                    )
                  ],
                ),
              ),
      );
  }
}