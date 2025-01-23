import 'package:get/get.dart';

class Tasbihcontroller extends GetxController{
  var counter = 0.obs;


  void incrementCounter(){
    counter ++;
  }

  void resetCounter(){
    counter.value = 0;
  }

}