import 'package:al_taqwa/colors.dart';
import 'package:al_taqwa/controllers/ReadDuaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadDua extends StatefulWidget {
  final String duaId;
  final String title;

  const ReadDua({super.key, required this.duaId, required this.title});

  @override
  State<ReadDua> createState() => _ReadDuaState();
}

class _ReadDuaState extends State<ReadDua> {
  final ReadDuaController _controller = Get.put(ReadDuaController());

  @override
  void initState() {
    super.initState();

    _controller.getDuaById(widget.duaId).then((_) {
      _controller.initializeExpansionStates(_controller.dua['sub_duas']?.length ?? 0);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteSmoke,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.primaryColor,
        title: Text(widget.title),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_controller.dua.isEmpty ||
            _controller.dua['sub_duas'] == null) {
          return const Center(child: Text("No data available"));
        } else {
          final dua = _controller.dua.value;
          return ListView.builder(
            itemCount: dua['sub_duas'].length,
            itemBuilder: (context, index) {
              final subDua = dua['sub_duas'][index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        subDua['title'] ?? 'Untitled',
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
                              subDua['arabicDua'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 12.0, bottom: 12.0),
                            child: Text(
                              "(${subDua['repeat'] ?? 1}x)",
                              style: const TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                          ExpansionPanelList(
                            expansionCallback:
                                (int panelIndex, bool isExpanded) {
                              setState(() {
                                _controller.toggleExpansion(index);
                              });
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
                                    subDua['translation'] ??
                                        'No translation available.',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                isExpanded: _controller.isExpandedList[index],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}