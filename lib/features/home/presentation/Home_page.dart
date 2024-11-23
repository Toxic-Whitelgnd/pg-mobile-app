import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/features/home/presentation/View_page.dart';
import 'package:pgapp/features/home/presentation/widgets/HomePageWidgets.dart';

import '../../../core/constants/constants.dart';
import '../model/HomePageModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PG",
        textAlign: TextAlign.center,),
        centerTitle: true,
      ),
      drawer: HomeDrawer(),

      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageBox1Implementation(),
            HomePageBox2Implementation(),
            HomePageOtherHeading(context),
            HomePageOtherthings(),
          ],
        ),
      ),
    );
  }

}
