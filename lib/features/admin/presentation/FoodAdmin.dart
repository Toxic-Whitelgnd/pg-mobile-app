import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodAdminScreen extends StatefulWidget {
  const FoodAdminScreen({super.key});

  @override
  State<FoodAdminScreen> createState() => _FoodAdminScreenState();
}

class _FoodAdminScreenState extends State<FoodAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Food Menu"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(

        ),
      ),
    );
  }
}
