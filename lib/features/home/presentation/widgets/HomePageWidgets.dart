import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgapp/features/admin/presentation/Admin_Page.dart';
import 'package:pgapp/features/amenitites/presentation/Amenities_Page.dart';

import '../../../../core/constants/ColorConstants.dart';
import '../../../../core/constants/constants.dart';
import '../View_page.dart';

Container HomeBox2(String name,IconData iconName,String imagename,Function customfunction) {
  return Container(
    width: 150,
    height: 130,
    decoration: BoxDecoration(
        color: CustomColors.primary1,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
              blurRadius: 1.4,
              offset: Offset(2, 2),
              spreadRadius: 1.2,
              color: Colors.black45)
        ]),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 30,
          left: 62,
          child: Image.asset(
            '$IMG_DIR/$imagename.png',
            width: 140,
            height: 140,
          ),
        ),
        Positioned(
          top: 70,
          left: 0,
          child: ElevatedButton(
              onPressed: (){
                customfunction();
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                      CircleBorder())),
              child:  Icon(
                iconName,
                color: Colors.white,
                size: 20,
              )),
        )
      ],
    ),
  );
}

Container HomePageBox1() {
  return Container(
    width: 320,
    height: 218,
    decoration: BoxDecoration(
        color: CustomColors.primary1,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(2, 2),
          )
        ]),
    child: Stack(
      children: [
        // Title text
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Know your Roommates!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Image placed inside Positioned widget
        Positioned(
          top: 40,
          left: 140,
          child: Image.asset(
            '$IMG_DIR/homeimg1.png',
            width: 230, // Adjust width as needed
            height: 240, // Adjust height as needed
          ),
        ),
        Positioned(
          top: 150,
          left: 20,
          child: ElevatedButton(
            onPressed: () {
              print("clicked");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Text(
              "View",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

SizedBox HomePageUsage(String name, IconData iconname, Function customfunction, [double height = 90]) {
  return SizedBox(
    height: height,
    child: Center(
      child: ElevatedButton.icon(

        onPressed: () {
          customfunction();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(CustomColors.secondary1),
          fixedSize: MaterialStateProperty.all(Size.fromWidth(270)),
        ),
        label: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        icon: Icon(
          iconname,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Row HomePageBox2Implementation() {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: HomeBox2("Menu", Icons.fastfood, "homeimg2", () {
          print("custom function for menu");
        }),
      ),
      Padding(
        padding: EdgeInsets.all(0),
        child: HomeBox2("Tickets", Icons.support_agent, "homeimg3", () {
          print("custom function for tickets");
        }),
      ),
    ],
  );
}

Padding HomePageBox1Implementation() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
    child: HomePageBox1(),
  );
}

Padding HomePageOtherHeading(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Other things ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Spacer(), // Pushes the TextButton to the far right
        TextButton(
          onPressed: () {
            // Add your onPressed function here
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewAllPage()));
          },
          child: const Text(
            "View All",
            style: TextStyle(
                fontSize: 16,
                color: Colors.blue), // Customize the color
          ),
        ),
      ],
    ),
  );
}

Expanded HomePageOtherthings(BuildContext context) {
  return Expanded(  // Ensure that this Expanded is around the entire scrollable area
    child: SingleChildScrollView(
      child: Column(
        children: [
          HomePageUsage("Amenities", Icons.sensors, () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AmenitiesScreen()));
          },50),
          SH10,
          HomePageUsage("Room Cleaning", Icons.cleaning_services, () {
            print("navigate to cleaning service");
          },50),
          SH10,
          HomePageUsage("Announcements", Icons.announcement, () {
            print("navigate to announcement service");
          },50),
        ],
      ),
    ),
  );
}

Drawer HomeDrawer(BuildContext context) {
  return Drawer(
    width: 260,
    backgroundColor: CustomColors.primary1,
    child: Column(

      children: [
        // Drawer Header
        DrawerHeader(

          child: Column(

            children: [
              Expanded(
                child: CircleAvatar(
                  maxRadius: 90,
                  minRadius: 60,
                  child: Image.asset('$IMG_DIR/homeimg1.png',
                    width: 220,
                    height: 220,
                  ),
                ),
              ),
              // const SizedBox(height: 10),

            ],
          ),
        ),
        // Drawer Body
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text("Profile", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle navigation to Home
                  print("Navigate to Profile page");
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text("About", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle navigation to About
                  print("Navigate to About");
                },
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings, color: Colors.white),
                title: Text("Admin", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle navigation to About
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text("Settings", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle navigation to Settings
                  print("Navigate to Settings");
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle logout functionality
                  print("Logged out");
                },
              ),
            ],
          ),
        ),
        // Optional Footer
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Version 1.0.0",
            style: TextStyle(color: CustomColors.secondary1, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
