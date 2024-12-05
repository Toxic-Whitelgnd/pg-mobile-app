import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/FoodMenuModel.dart';

Padding MenuCard(FoodMenu f) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Colors.black45,
                )
              ]),
          child: Image.asset(
            f.img, // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            f.day,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 10),
        Positioned(
          top: 75,
          left: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Morning: ${f.session1}',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              Text('Afternoon: ${f.session2}',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              Text('Night: ${f.session3}',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
            ],
          ),
        ),
        SizedBox(height: 5),
      ],
    ),
  );
}