import 'package:al_taqwa/colors.dart';
import 'package:al_taqwa/controllers/ReadDuaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadDua extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final ReadDuaController controller = Get.put(ReadDuaController());

    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.primaryColor,
        title: const Text("Morning Adhkar"),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Ayat al-Kursi: The Greatest Protection",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "أَعُوْذُ بِاللّٰهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ. اَللّٰهُ لَآ إِلٰهَ إِلَّا هُوَ الْحَىُّ الْقَيُّوْمُ ، لَا تَأْخُذُهُۥ سِنَةٌ وَّلَا نَوْمٌ ، لَهُ مَا فِى السَّمٰـوٰتِ وَمَا فِى الْأَرْضِ ، مَنْ ذَا الَّذِىْ يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِۦ ، يَعْلَمُ مَا بَيْنَ أَيْدِيْهِمْ وَمَا خَلْفَهُمْ ، وَلَا يُحِيْطُوْنَ بِشَىْءٍ مِّنْ عِلْمِهِٓ إِلَّا بِمَا شَآءَ ، وَسِعَ كُرْسِيُّهُ السَّمٰـوٰتِ وَالْأَرْضَ، وَلَا يَئُوْدُهُۥ حِفْظُهُمَا ، وَهُوَ الْعَلِىُّ الْعَظِيْمُ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
                        child: Text(
                          "(1x)",
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      Obx(() => ExpansionPanelList(
                        expansionCallback: (int panelIndex, bool isExpanded) {
                          controller.toggleExpansion();
                        },
                        children: [
                          ExpansionPanel(
                            backgroundColor: AppColors.lightBlue,
                            headerBuilder: (context, isExpanded) {
                              return const ListTile(
                                title: Text(
                                  "Translation",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "I seek the protection of Allah from the accursed Shayṭān. Allah, there is no god worthy of worship but He, the Ever Living, The Sustainer of all. Neither drowsiness overtakes Him nor sleep. To Him Alone belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except with His permission? He knows what is before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursī extends over the heavens and the earth, and their preservation does not tire Him. And He is the Most High, the Magnificent.",
                              ),
                            ),
                            isExpanded: controller.isExpanded.value,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}