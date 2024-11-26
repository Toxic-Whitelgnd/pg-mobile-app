import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../amenitites/presentation/Amenities_Page.dart';
import '../../home/presentation/widgets/HomePageWidgets.dart';
import 'AddClient_Page.dart';
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
          HomePageUsage("Add Client", Icons.comment_bank, () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminAddClientScreen()));
          },50),
          SH10,
        ],
      ),
    );
  }
}
