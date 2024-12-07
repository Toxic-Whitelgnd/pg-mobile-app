import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/services/MongoDB.dart';
import 'package:pgapp/services/dataService/amenitieService.dart';

import '../../../core/constants/constants.dart';
import '../model/AmenitiesModel.dart';

class AmenitiesScreen extends StatefulWidget {
  const AmenitiesScreen({super.key});

  @override
  State<AmenitiesScreen> createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  final AmenityService _amenityService = locator<AmenityService>();
  List<Amenities>? amenities;

  Future<void> getAmenities() async {
    var res = await _amenityService.getAmenitiesData();
    if (res.isNotEmpty) {
      setState(() {
        amenities = res;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAmenities();
  }

  @override
  void dispose() {
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
              child: amenities == null
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      itemCount: amenities!
                          .length, // You can change this to the number of items you want
                      itemBuilder: (context, index) {
                        final item = amenities![index];
                        return AmenitesCard(item);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // AmenitesCard widget
  Container AmenitesCard(Amenities a) {
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
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 40,
            child: Column(
               // Adjust the column size to the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              children: [
                Icon(
                  iconMap[a.icon], // Use the icon from your iconMap
                  size: 46,
                  color: Colors.white70,
                ),
                SizedBox(height: 8), // Space between the icon and text
                Text(
                  a.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
