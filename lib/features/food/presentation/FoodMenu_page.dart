import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/features/food/model/FoodMenuModel.dart';
import 'package:pgapp/features/food/model/FoodModel.dart';

import '../../../core/constants/constants.dart';
import '../utils/FoodMenuUtils.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  List<FoodMenu>? details;

  final Food _f1 = Food();

  @override
  void initState() {
    super.initState();

    FoodMenu mondayMenu = FoodMenu(
      day: 'Monday',
      session1: 'Breakfast',
      session2: 'Lunch',
      session3: 'Dinner',
      img: '$IMG_DIR/homeimg1.png',
    );

    FoodMenu tuesdayMenu = FoodMenu(
      day: 'Tuesday',
      session1: 'Breakfast Special',
      session2: 'Lunch Special',
      session3: 'Dinner Special',
      img: '$IMG_DIR/homeimg1.png',
    );

    FoodMenu wednesdayMenu = FoodMenu(
      day: 'Wednesday',
      session1: 'Breakfast Special',
      session2: 'Lunch Special',
      session3: 'Dinner Special',
      img: '$IMG_DIR/homeimg1.png',
    );
    FoodMenu thursdayMenu = FoodMenu(
      day: 'Thursday',
      session1: 'Breakfast Special',
      session2: 'Lunch Special',
      session3: 'Dinner Special',
      img: '$IMG_DIR/homeimg1.png',
    );

    FoodMenu fridayMenu = FoodMenu(
      day: 'Friday',
      session1: 'Breakfast Special',
      session2: 'Lunch Special',
      session3: 'Dinner Special',
      img: '$IMG_DIR/homeimg1.png',
    );


    _f1.addToMenu(mondayMenu);
    _f1.addToMenu(tuesdayMenu);
    _f1.addToMenu(wednesdayMenu);
    _f1.addToMenu(thursdayMenu);
    _f1.addToMenu(fridayMenu);

    details = _f1.getMenus();
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
