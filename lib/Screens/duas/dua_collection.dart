import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';


import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';

class DuaCollection extends StatefulWidget {
  const DuaCollection({super.key});

  @override
  State<DuaCollection> createState() => _DuaCollectionState();
}

class _DuaCollectionState extends State<DuaCollection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle tap
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Container(
                    height: 82,
                    width: double.infinity,
                    color: Colors.blue[400],
                    child: Image.network(
                      "https://lifewithallah.com/wp-content/uploads/2021/07/img-waking-up-1.svg",
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('Failed to load image'));
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 32.22,
                    color: AppColors.lightBlue,
                    child: const Center(
                      child: Text(
                        "Morning Adhkar",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}