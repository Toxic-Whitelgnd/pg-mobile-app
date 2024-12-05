import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/features/food/model/FoodMenuModel.dart';
import 'package:pgapp/features/food/model/FoodModel.dart';

import '../../../core/constants/constants.dart';
import '../../../di/locator.dart';
import '../../../services/dataService/foodService.dart';
import '../utils/FoodMenuUtils.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final FoodService _foodService = locator<FoodService>();
  List<FoodMenu>? details;

  Future<void> _getFoodMenu() async{
      var res = await _foodService.getFoodMenu();
      setState(() {
        details = res;
      });
  }

  @override
  void initState() {
    super.initState();

    _getFoodMenu();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Menu"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: details != null
              ? ListView.builder(
                  itemCount: details!.length,
                  itemBuilder: (context, index) {
                    FoodMenu item = details![index];
                    return MenuCard(item);
                  })
              : Text("No Menus found")),
    );
  }


}
