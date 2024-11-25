import 'package:bson/src/classes/object_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/services/MongoDB.dart';

class AdminComplaintsPage extends StatefulWidget {
  const AdminComplaintsPage({super.key});

  @override
  State<AdminComplaintsPage> createState() => _AdminComplaintsPageState();
}

class _AdminComplaintsPageState extends State<AdminComplaintsPage> {
  final MongoDBService _mongoDBService = MongoDBService();
  List<Map<String, dynamic>>? complaints;
  bool isLoading = true;

  List<String> items = [
    "All",
    "Not Resolved",
    "Resolved",
    "Bathroom",
    "Outdoor"
  ];
  String selectedCategory = "All";

  List<Map<String, dynamic>>? filteredComplaints;

  @override
  void initState() {
    super.initState();
    getComplaintData();
  }

  Future<void> getComplaintData() async {
    try {
      complaints = await _mongoDBService.getComplaints();
      filteredComplaints = complaints;
    } catch (e) {
      print("Error fetching complaints: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterCompalints(String category) {
    if (category == "All") {
      // Show all complaints
      setState(() {
        filteredComplaints = complaints;
      });
    } else if (category == "Resolved") {
      setState(() {
        filteredComplaints = complaints
            ?.where((element) => element['isResolved'] == true)
            .toList();
      });
    } else if (category == "Not Resolved") {
      setState(() {
        filteredComplaints = complaints
            ?.where((element) => element['isResolved'] == false)
            .toList();
        print("not resolvedd");
      });
    } else if (category == "Bathroom") {
      setState(() {
        filteredComplaints = complaints
            ?.where((element) => element['category'] == "Bathroom")
            .toList();
      });
    } else if (category == "Outdoor") {
      setState(() {
        filteredComplaints = complaints
            ?.where((element) => element['category'] == "Outdoor")
            .toList();
      });
    }
  }

  Future<void> changeStatus(ObjectId id) async {
    //make call to db
    bool res = await _mongoDBService.changeStatus(id);
    if(res){
      setState(() {
        getComplaintData();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints Raised"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = item;
                        filterCompalints(item);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == item
                            ? CustomColors.primary1
                            : CustomColors.secondary1,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                              color: selectedCategory == item
                                  ? Colors.black45
                                  : Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredComplaints == null || filteredComplaints!.isEmpty
                      ? const Center(child: Text("No complaints available"))
                      : ListView.builder(
                          itemCount: filteredComplaints!.length,
                          itemBuilder: (context, index) {
                            final complaint = filteredComplaints![index];
                            return ComplaintCard(
                                complaint['roomNo'] ?? "N/A",
                                complaint['category'] ?? "N/A",
                                complaint['complaint'] ?? "N/A", () {

                              print("Resolve for ${complaint['_id']}");
                              changeStatus(complaint['_id']);
                            }, complaint['dateTime'].toString() ?? "N/A",
                                complaint['isResolved']);
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

Padding ComplaintCard(String roomNo, String category, String reason,
    VoidCallback onresolve, String dateTime, bool isResolved) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    child: Container(
      width: 320,
      height: 200,
      decoration: BoxDecoration(
          color: isResolved == true ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: Colors.black45,
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            left: 12,
            top: 5,
            child: Text(
              "$dateTime".substring(0, 10),
              style: ComplaintStyle(),
            ),
          ),
          Positioned(
            left: 180,
            top: 5,
            child: Text(
              "RoomNo: $roomNo",
              style: ComplaintStyle(),
            ),
          ),
          Positioned(
            left: 12,
            top: 55,
            child: Text(
              "$category:",
              style: ComplaintStyle(),
            ),
          ),
          Positioned(
            left: 12,
            top: 85,
            child: Text(
              reason.length > 50 ? "$reason".substring(0,50)+"..." : "$reason",
              style: ComplaintStyle(),
            ),
          ),
          Positioned(
            top: 160,
            left: 20,
            child: Text(isResolved ? "*Resolved*" : " ",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
          Positioned(
            top: 150,
            left: 200,

            child: ElevatedButton(onPressed: isResolved ? null : onresolve,

                child: Text("Resolve")),
          ),
        ],
      ),
    ),
  );
}

TextStyle ComplaintStyle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}
