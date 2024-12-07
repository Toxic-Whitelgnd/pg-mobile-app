import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgapp/core/constants/constants.dart';
import 'package:pgapp/features/complaints/presentation/ComplaintScreen.dart';
import 'package:pgapp/features/home/presentation/widgets/HomePageWidgets.dart';
import 'package:pgapp/features/rent/presentation/PayRentScreen.dart';
import 'package:pgapp/features/roomcleaning/presentation/RoomCleaning_Page.dart';

import '../../admin/presentation/AdminRoomClient_Page.dart';
import '../../amenitites/presentation/Amenities_Page.dart';
import '../../annoucement/presentation/AnnoucementLog_Page.dart';
import '../../food/presentation/FoodMenu_page.dart';
import '../model/HomePageModel.dart';

class ViewAllPage extends StatelessWidget {
  const ViewAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HomePageItem> items = [
      HomePageItem(
        name: "Amenities",
        icon: Icons.sensors,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AmenitiesScreen()));
        },
      ),
      HomePageItem(
        name: "Room Cleaning",
        icon: Icons.cleaning_services,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RoomCleaningScreen()));
        },
      ),

      HomePageItem(
        name: "Announcements",
        icon: Icons.announcement_rounded,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AnnoucementLogScreen(isAdmin: false)));
        },
      ),
      HomePageItem(
        name: "Food Menu",
        icon: Icons.fastfood_rounded,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FoodMenuScreen()));
        },
      ),
      HomePageItem(
        name: "Roomates",
        icon: Icons.person_add_alt_rounded,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AdminRoomClientScreen(floorno: '1', roomno: '101',
                      isAdmin: false,)));
        },
      ),
      HomePageItem(
        name: "Pay Rent",
        icon: Icons.attach_money,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PayRentScreen()));
        },
      ),
      HomePageItem(
        name: "Raise Complaints",
        icon: Icons.comment_outlined,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintScreen()));
        },
      ),
      HomePageItem(
        name: "Emerg Contacts",
        icon: Icons.contact_emergency,
        onPressed: () {
          print("navigate to cleaning service");
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Features")),
      body: ListView(
        children: items.map((item) {
          return HomePageUsage(item.name, item.icon, item.onPressed);
        }).toList(),
      ),
    );
  }
}
