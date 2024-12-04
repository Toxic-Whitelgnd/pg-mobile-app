import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pgapp/core/constants/constants.dart';
import 'package:pgapp/features/roomcleaning/model/RoomCleanServiceModel.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../../roomcleaning/model/RoomCleaningModel.dart';

class RoomCleaningAdminScreen extends StatefulWidget {
  const RoomCleaningAdminScreen({super.key});

  @override
  State<RoomCleaningAdminScreen> createState() =>
      _RoomCleaningAdminScreenState();
}

class _RoomCleaningAdminScreenState extends State<RoomCleaningAdminScreen> {
  MongoDBService _mongoDBService = new MongoDBService();
  RoomCleanService rs = new RoomCleanService();

  List<RoomCleaning>? fromDb;
  bool isloading = false;

  String mondayDate = '';
  String sundayDate = '';

  final List<RoomCleaning> daysOfWeek = [
    RoomCleaning("Monday", false),
    RoomCleaning("Tuesday", false),
    RoomCleaning("Wednesday", false),
    RoomCleaning("Thursday", false),
    RoomCleaning("Friday", false),
    RoomCleaning("Saturday", false),
    RoomCleaning("Sunday", false),
  ];

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final MaterialStateProperty<Color?> thumbColor =
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return Colors.red.withOpacity(.48);
    }
    if (states.contains(MaterialState.selected)) {
      return Colors.green;
    }
    return Colors.red.withOpacity(0.78);
  });

  void toggleDay(String day, bool value) {
    setState(() {
      final room = fromDb!.firstWhere((element) => element.day == day);
      room.isCleaned = value;
      room.lastUpdated = DateTime.now().toString();
    });
  }

  Future<void> _getRoomCleaning() async {
    setState(() {
      isloading = true;
    });
    var res = await _mongoDBService.fetchRoomCleanings();
    if(res.isNotEmpty){

      setState(() {
        fromDb = res;
        isloading = false;
      });
    }
  }

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
    _getRoomCleaning();
    _getCurrentWeekDates();
  }

  @override
  void dispose() {


    for (var r in fromDb!) {
      rs.addToRoomClean(r);
    }

    final res = rs.getRoomClean();

    _mongoDBService.saveRoomCleaning(res);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("RoomCleaning \n $mondayDate - $sundayDate"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(12),
            child:  isloading
                ? Text("") : ListView.builder(
                    itemCount: fromDb!.length,
                    itemBuilder: (context, index) {
                      final item = fromDb![index];

                      return RoomCleaningAdmin(item, (onNewVal) {
                        toggleDay(item.day, onNewVal);
                      });
                    })),
      ),
    );
  }

  Row RoomCleaningAdmin(RoomCleaning r, ValueChanged<bool> onChange) {
    return Row(
      children: [
        Text(
          "${r.day}",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Switch(
          value: r.isCleaned,
          onChanged: onChange,
          thumbIcon: thumbIcon,
          thumbColor: thumbColor,
          activeTrackColor: Colors.green.withOpacity(0.45),
          inactiveTrackColor: Colors.red.withOpacity(0.45),
        ),
      ],
    );
  }
}
