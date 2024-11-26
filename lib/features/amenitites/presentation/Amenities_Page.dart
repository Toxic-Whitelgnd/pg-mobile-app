import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/services/MongoDB.dart';

class AmenitiesScreen extends StatefulWidget {
  const AmenitiesScreen({super.key});

  @override
  State<AmenitiesScreen> createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  final MongoDBService _mongoService = MongoDBService();

  @override
  void initState() {
    super.initState();
    // _mongoService.connect();
  }

  @override
  void dispose() {
    // _mongoService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amenities"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Wrap GridView.builder with Expanded to give it a finite height
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: 10, // You can change this to the number of items you want
                itemBuilder: (context, index) {
                  return AmenitesCard();
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _mongoService.getAmenitiesData();
            },
            child: Text("Click to get"),
          ),
        ],
      ),
    );
  }

  // AmenitesCard widget
  Container AmenitesCard() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.secondary1,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      width: 130,
      height: 130,
      child: const Stack(
        children: [
          Positioned(
            top: 80,
            left: 40,
            child: Text(
              "Wifi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 45,
            child: Icon(
              size: 46,
              Icons.wifi,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

