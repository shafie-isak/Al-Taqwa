import 'package:al_taqwa/Screens/duas/read_dua.dart';
import 'package:al_taqwa/colors.dart';
import 'package:al_taqwa/controllers/ReadDuaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DuaCollection extends StatefulWidget {
  const DuaCollection({super.key});

  @override
  State<DuaCollection> createState() => _DuaCollectionState();
}

class _DuaCollectionState extends State<DuaCollection> {
  final DuaCollectionController _controller =
      Get.put(DuaCollectionController());

  @override
  void initState() {
    super.initState();
    _controller.fetchDuas();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_controller.duas.isEmpty) {
          return const Center(child: Text("No duas available"));
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: _controller.duas.length,
            itemBuilder: (context, index) {
              final dua = _controller.duas[index];

              return GestureDetector(
                onTap: () {
                  if (dua['_id'] != null) {
                    Get.to( ReadDua(duaId: dua['_id'], title: dua["title"]));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid dua ID')),
                    );
                  }
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
                        height: 131,
                        width: double.infinity,
                        color: Colors.blue[400],
                        child: dua["image"] != null
                            ? Image.network(
                                dua["image"],
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image_not_supported, size: 50),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment(0, 0),
                        padding: EdgeInsets.all(8.0),
                        height: 45,
                        color: AppColors.lightBlue,
                        child: Center(
                          child: Text(
                            dua["title"] ?? "No title available",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}