import 'package:flutter/material.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/services/dataService/foodService.dart';

import '../../../core/constants/constants.dart';
import '../../../utils/Utils.dart';
import '../../food/model/FoodMenuModel.dart';

class FoodAdminScreen extends StatefulWidget {
  const FoodAdminScreen({super.key});

  @override
  State<FoodAdminScreen> createState() => _FoodAdminScreenState();
}

class _FoodAdminScreenState extends State<FoodAdminScreen> {
  final FoodService _foodService = locator<FoodService>();

  // List of FoodMenu objects
  List<FoodMenu> foodMenuList = [
    FoodMenu(day: "Monday", session1: "", session2: "", session3: "", img: ""),
    FoodMenu(day: "Tuesday", session1: "", session2: "", session3: "", img: ""),
    FoodMenu(
        day: "Wednesday", session1: "", session2: "", session3: "", img: ""),
    FoodMenu(
        day: "Thursday", session1: "", session2: "", session3: "", img: ""),
    FoodMenu(day: "Friday", session1: "", session2: "", session3: "", img: ""),
    FoodMenu(
        day: "Saturday", session1: "", session2: "", session3: "", img: ""),
    FoodMenu(day: "Sunday", session1: "", session2: "", session3: "", img: ""),
  ];

  List<FoodMenu>? foodMenuDb;

  void sendToServer() async {
    bool res = await _foodService.addFoodItems(foodMenuDb!);
    if (res) {
      CustomToaster(context,"Food Menu Updated",Colors.green);
    }
  }

  Future<void> _getFoodMenus() async {
    var res = await _foodService.getFoodMenu();

    setState(() {
      foodMenuDb = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFoodMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food Menu"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: foodMenuDb == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: foodMenuDb!.length,
                itemBuilder: (context, index) {
                  FoodMenu foodMenu = foodMenuDb![index];
                  return GestureDetector(
                    onTap: () {
                      customShowModalBottomSheet(context, foodMenu);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: CustomColors.secondary1,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          foodMenu.day,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendToServer,
        child: const Icon(Icons.send),
      ),
    );
  }

  Future<dynamic> customShowModalBottomSheet(
      BuildContext context, FoodMenu foodMenu) {
    // Temporary variables to hold input values
    TextEditingController session1Controller = TextEditingController(
      text: foodMenu.session1,
    );
    TextEditingController session2Controller = TextEditingController(
      text: foodMenu.session2,
    );
    TextEditingController session3Controller = TextEditingController(
      text: foodMenu.session3,
    );

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                foodMenu.day,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SH30,
              TextField(
                controller: session1Controller,
                decoration: const InputDecoration(
                    hintText: "Breakfast",
                    hintFadeDuration: Duration(seconds: 1)),
              ),
              SH30,
              TextField(
                controller: session2Controller,
                decoration: const InputDecoration(
                    hintText: "Lunch", hintFadeDuration: Duration(seconds: 1)),
              ),
              SH30,
              TextField(
                controller: session3Controller,
                decoration: const InputDecoration(
                    hintText: "Dinner", hintFadeDuration: Duration(seconds: 1)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Save the values to the foodMenu map
                      setState(() {
                        // Update the FoodMenu object
                        foodMenu.session1 = session1Controller.text;
                        foodMenu.session2 = session2Controller.text;
                        foodMenu.session3 = session3Controller.text;
                      });

                      // Close the bottom sheet
                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
