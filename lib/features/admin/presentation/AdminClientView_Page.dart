import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';

import '../utils/adminConstants.dart';
import 'AdminRoomClient_Page.dart';

class AdminClientViewScreen extends StatefulWidget {
  const AdminClientViewScreen({super.key});

  @override
  State<AdminClientViewScreen> createState() => _AdminClientViewScreenState();
}

class _AdminClientViewScreenState extends State<AdminClientViewScreen> {
  List<String>? _selectedFloorRooms;
  String _selectedFloor = floors.first;
  String _selectedRoom = floor1.first;

  void _changeFloor(String? floor) {
    setState(() {
      _selectedFloor = floor!;
    });
    switch (_selectedFloor) {
      case "floor 1":
        _selectedFloorRooms = floor1;
        break;
      case "floor 2":
        _selectedFloorRooms = floor2;
        break;
      case "floor 3":
        _selectedFloorRooms = floor3;
        break;
      case "floor 4":
        _selectedFloorRooms = floor4;
        break;
      case "floor 5":
        _selectedFloorRooms = floor5;
        break;
      default:
        _selectedFloorRooms = floor1;
        break;
    }

    _selectedRoom = _selectedFloorRooms!.first;
  }

  @override
  void initState() {
    super.initState();
    _selectedFloorRooms = floor1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Rooms"),
        centerTitle: true,
      ),
      body: ClietViewAddRoom(),
    );
  }

  Padding ClietViewAddRoom() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _selectedFloor,
                items: floors.map((String f) {
                  return DropdownMenuItem(value: f, child: Text(f));
                }).toList(),
                onChanged: _changeFloor,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount:
                    10, // You can change this to the number of items you want
                itemBuilder: (context, index) {
                  final rooms = _selectedFloorRooms?[index] ?? floor1[index];
                  return ClientRoomWidget(rooms, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminRoomClientScreen(
                                  floorno: rooms.substring(0, 1),
                                  roomno: rooms,
                                  isAdmin: true,
                                )));
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector ClientRoomWidget(String roomno, VoidCallback roomFunction) {
    return GestureDetector(
      onTap: roomFunction,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: CustomColors.secondary1,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black45,
                spreadRadius: 1,
              ),
            ]),
        child: Center(
          child: Text(
            "$roomno",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
