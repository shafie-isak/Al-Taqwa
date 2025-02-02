import 'package:al_taqwa/Screens/about/about.dart';
import 'package:al_taqwa/colors.dart';
import 'package:al_taqwa/controllers/UsersController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final UsersController controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    Widget buildDrawerItem({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
    }) {
      return ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
        onTap: onTap,
      );
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.lightBlue,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.whiteSmoke,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => Text(
                      controller.userName.value.isNotEmpty
                          ? controller.userName.value
                          : 'Guest User',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Obx(() => Text(
                      controller.userEmail.value.isNotEmpty
                          ? controller.userEmail.value
                          : 'guest@example.com',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildDrawerItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    Get.back();
                    Get.to(About());
                  },
                ),
                buildDrawerItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                buildDrawerItem(
                  icon: Icons.feedback_outlined,
                  title: 'Feedback',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: controller.LogoutUser,
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.lightBlue,
                foregroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}