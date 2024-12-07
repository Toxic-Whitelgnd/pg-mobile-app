import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgapp/features/admin/presentation/AmenitiesAdmin_Page.dart';
import 'package:pgapp/features/admin/presentation/AnnoucementAdmin_Page.dart';
import 'package:pgapp/features/admin/presentation/CleaningServiceAdmin_Page.dart';
import 'package:pgapp/features/admin/presentation/ClientHistory_Page.dart';
import 'package:pgapp/features/admin/presentation/FoodAdmin.dart';

import '../../../core/constants/constants.dart';
import '../../amenitites/presentation/Amenities_Page.dart';
import '../../home/presentation/widgets/HomePageWidgets.dart';
import 'AddClient_Page.dart';
import 'AdminClientView_Page.dart';
import 'ViewComplaintsPage.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminPage"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          HomePageUsage("View Complaints", Icons.comment_bank, () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminComplaintsPage()));
          },50),
          SH10,
          HomePageUsage("Add Client", Icons.add, () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminAddClientScreen()));
          },50),
          SH10,
          HomePageUsage("Rooms", Icons.remove_red_eye, () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AdminClientViewScreen()));
          },50),
          SH10,
          HomePageUsage("History", Icons.history, (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ClientHistoryScreen()));
          },50),
          SH10,
          HomePageUsage("RoomCleaning", Icons.cleaning_services, (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const RoomCleaningAdminScreen()));
          },50),
          SH10,
          HomePageUsage("Food", Icons.fastfood_sharp, (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const FoodAdminScreen()));
          },50),
          SH10,
          HomePageUsage("Make Announcement", Icons.announcement_outlined, (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnnoucementScreen()));
          },50),
          SH10,
          HomePageUsage("Amenities", Icons.add_box_rounded, (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AmenitiesAdminScreen()));
          },50),
        ],
      ),
    );
  }
}
