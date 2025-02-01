import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReadDuaController extends GetxController {
  var dua = {}.obs;
  var isLoading = true.obs;
  var isExpandedList = <bool>[].obs;

  Future<void> getDuaById(String id) async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/api/duas/$id'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        dua.assignAll(data ?? {});

        if (dua['sub_duas'] == null) {
          dua['sub_duas'] = [];
        }
      } else {
        throw Exception('Failed to load dua');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dua: $e 😟',
          snackPosition: SnackPosition.TOP);
      print("Error fetching dua: $e");
    } finally {
      isLoading(false);
    }
  }

  void initializeExpansionStates(int itemCount) {
    isExpandedList.value = List<bool>.filled(itemCount, false);
  }

  void toggleExpansion(int index) {
    isExpandedList[index] = !isExpandedList[index];
    isExpandedList.refresh();
  }
}

class DuaCollectionController extends GetxController {
  var duas = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDuas();
  }

  Future<void> fetchDuas() async {
    try {
      isLoading(true);
      print("Fetching duas from API...");
      var response =
          await http.get(Uri.parse('http://10.0.2.2:5000/api/duas'));
      print("Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        print("Data received: $data");
        duas.value = data.map((item) => item as Map<String, dynamic>).toList();
        print(data);
        Get.snackbar('Success', 'Successfully loaded 😀',
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar('Error', 'Failed to load duas 😟',
            snackPosition: SnackPosition.TOP);
        throw Exception('Failed to load duas');
      }
    } catch (e) {
      Get.snackbar('Error', 'An Error Occurred: $e 😟',
          snackPosition: SnackPosition.TOP);
      print("Detailed error: $e");
    } finally {
      isLoading(false);
      print("Loading completed.");
    }
  }
}
