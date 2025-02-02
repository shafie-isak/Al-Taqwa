import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.primaryColor,
        title: const Text("About"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.secondaryColor,
                child: CircleAvatar(
                  radius: 38,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                        "https://w7.pngwing.com/pngs/253/1015/png-transparent-jamhuriya-university-of-science-and-technology-mogadishu-university-jamhuriya-university-just-organization-others-logo-university-business-thumbnail.png"),
                  ),
                )),
                SizedBox(height: 7,),
                Text("(JUST)", style: TextStyle(fontSize: 18),),
              ],
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                child: const Text(
                  "This application has been developed by students of Jamhuriya University of Science and Technology (JUST) with the aim of assisting users in enhancing their Islamic routines. The app serves as a comprehensive tool for spiritual growth, offering features such as reminders for Adhkar (daily supplications), the ability to set and manage To-Do Adhkar, access to a rich collection of Duas (supplications), and a digital Tasbih (prayer counter) for engaging in Dhikr (remembrance of Allah). Through these features, the application provides a seamless and structured approach to incorporating essential Islamic practices into daily life",
                )),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Contributors",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                    padding: const EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.secondaryColor,
                            child: CircleAvatar(
                              radius: 38,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    "https://w7.pngwing.com/pngs/400/768/png-transparent-laptop-computer-icons-user-drawing-computer-user-miscellaneous-blue-rectangle-thumbnail.png"),
                              ),
                            )),
                        const Text("Shafie Isak", style: TextStyle(fontSize: 16),)
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                  width: 160,
                  height: 160,
                    padding: const EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.secondaryColor,
                            child: CircleAvatar(
                              radius: 38,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    "https://w7.pngwing.com/pngs/400/768/png-transparent-laptop-computer-icons-user-drawing-computer-user-miscellaneous-blue-rectangle-thumbnail.png"),
                              ),
                            )),
                        const Text("Bile Abdikadir", style: TextStyle(fontSize: 16),)
                      ],
                    ),
                  )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                    padding: const EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.secondaryColor,
                            child: CircleAvatar(
                              radius: 38,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    "https://w7.pngwing.com/pngs/400/768/png-transparent-laptop-computer-icons-user-drawing-computer-user-miscellaneous-blue-rectangle-thumbnail.png"),
                              ),
                            )),
                        const Text("Abdulkar Husein", style: TextStyle(fontSize: 16),)
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                  width: 160,
                  height: 160,
                    padding: const EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.secondaryColor,
                            child: CircleAvatar(
                              radius: 38,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    "https://w7.pngwing.com/pngs/400/768/png-transparent-laptop-computer-icons-user-drawing-computer-user-miscellaneous-blue-rectangle-thumbnail.png"),
                              ),
                            )),
                        const Text("Shafie Abdi", style: TextStyle(fontSize: 16),)
                      ],
                    ),
                  )
              ],
            ),
            SizedBox(height: 20,),
            Divider(
              color: AppColors.lightBlue,
              height: 20,
            ),
            Text("All Reserved By Al-Taqwa(2025)", textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
