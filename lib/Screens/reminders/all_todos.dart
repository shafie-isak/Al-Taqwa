import 'package:al_taqwa/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AllTodo extends StatefulWidget {
  const AllTodo({super.key});

  @override
  State<AllTodo> createState() => _AllTodoState();
}

bool _isChecked = false;

class _AllTodoState extends State<AllTodo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Card(
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: AppColors.lightBlue,
            elevation: 0,
            child: ListTile(
              leading: GestureDetector(
                onTap: () =>{
                  setState(() {
                    _isChecked = !_isChecked;
                  }),
                },
                child: Icon(_isChecked ? Icons.check_box : Icons.check_box_outline_blank, size: 35,color: AppColors.primaryColor,),
              ),
              title: const Text(
                "Alarm 1",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Every Day"), Text("6:00 AM")],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
