import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pgapp/core/constants/constants.dart';
import 'package:pgapp/features/roomcleaning/model/RoomCleanServiceModel.dart';
import 'package:pgapp/features/roomcleaning/model/RoomCleaningModel.dart';

class RoomCleaningScreen extends StatefulWidget {
  const RoomCleaningScreen({super.key});

  @override
  State<RoomCleaningScreen> createState() => _RoomCleaningScreenState();
}

class _RoomCleaningScreenState extends State<RoomCleaningScreen> {
  RoomCleanService rs = new RoomCleanService();

  List<RoomCleaning>? roomcleanDetails;
  String mondayDate = '';
  String sundayDate = '';

  void _AddtoRoomService() {
    RoomCleaning mon = RoomCleaning('Monday', true);
    RoomCleaning fri = RoomCleaning('Friday', true);
    RoomCleaning sat = RoomCleaning('Saturday', true);
    RoomCleaning tue = RoomCleaning('Tuesday', false);
    RoomCleaning wed = RoomCleaning('Wednesday', true);
    RoomCleaning thu = RoomCleaning('Thursday', false);
    RoomCleaning sun = RoomCleaning('Sunday', false);

    rs.addToRoomClean(mon);
    rs.addToRoomClean(tue);
    rs.addToRoomClean(wed);
    rs.addToRoomClean(thu);
    rs.addToRoomClean(fri);
    rs.addToRoomClean(sat);
    rs.addToRoomClean(sun);
  }

  void _getAndAssign() {
    var res = rs.getRoomClean();
    roomcleanDetails = res;
  }

  // Function to get the dates for Monday and Sunday of the current week
  void _getCurrentWeekDates() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday; // Monday = 1, Sunday = 7

    // Calculate Monday of the current week
    DateTime monday = now.subtract(Duration(days: currentWeekday - 1));

    // Calculate Sunday of the current week
    DateTime sunday = monday.add(Duration(days: 6));

    // Format the dates
    mondayDate = DateFormat('MMM d, yyyy').format(monday);
    sundayDate = DateFormat('MMM d, yyyy').format(sunday);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _AddtoRoomService();
    _getAndAssign();
    _getCurrentWeekDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Cleaning \n $mondayDate - $sundayDate"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: ListView.builder(
              itemCount: roomcleanDetails!.length,
              itemBuilder: (context, index) {
                final item = roomcleanDetails![index];
                return RoomCleaningCard(item);
              })),
    );
  }

  Padding RoomCleaningCard(RoomCleaning r) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 230,
          height: 60,
          decoration: BoxDecoration(
            color: r.isCleaned ? Colors.green : Colors.redAccent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0.5,
                color: Colors.black87,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -12,
                left: 210,
                child: Image.asset(
                  r.isCleaned
                      ? '$IMG_DIR/cleaning.png'
                      : '$IMG_DIR/nocleaning.png',
                  width: r.isCleaned ? 130 : 150,
                  height:  r.isCleaned ? 85 : 80,
                ),
              ),
              Positioned(
                  left: 5,
                  top: 2,
                  child: Text(
                    "${r.day}       LastUpdated:${r.lastUpdated == '' ? "Not updated" : "${r.lastUpdated}"}",
                    style: TextStyle(fontSize: 16),
                  )),
              Positioned(
                top: 30,
                left: 5,
                child: Text(
                  "${r.isCleaned ? "Cleaning Day" : "No Cleaning"}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )),
    );
  }
}
