// string - name , icondata - icon, bool - enabled
//1 . model , list of amenities , use this in admin screen , add save button
//

import 'package:flutter/material.dart';

import '../../amenitites/model/AmenitiesModel.dart';

class AmenitiesList{

  List<Amenities> amenities = [
    Amenities('Wifi', 'Wifi', false),
    Amenities('Pool', 'Pool', false),
    Amenities('Parking', 'Parking', false),
    Amenities('Gym', 'Gym', false),
    Amenities('AC', 'AC', false),
    Amenities('TV', 'TV', false),
    Amenities('Restaurant', 'Restaurant', false),
    Amenities('Bar', 'Bar', false),
    Amenities('Spa', 'Spa', false),
    Amenities('Laundry', 'Laundry', false),
    Amenities('24/7 Support', '24/7 Support', false),
    Amenities('Elevator', 'Elevator', false),
    Amenities('Fireplace', 'Fireplace', false),
    Amenities('Game Room', 'Game Room', false),
    Amenities('Garden', 'Garden', false),
    Amenities('Pet Friendly', 'Pet Friendly', false),
    Amenities('Smoke-Free', 'Smoke-Free', false),
    Amenities('Jacuzzi', 'Jacuzzi', false),
    Amenities('Terrace', 'Terrace', false),
    Amenities('Workspace', 'Workspace', false),
    Amenities('Library', 'Library', false),
    Amenities('Security', 'Security', false),
    Amenities('Sauna', 'Sauna', false),
    Amenities('Free Breakfast', 'Free Breakfast', false),
  ];

}