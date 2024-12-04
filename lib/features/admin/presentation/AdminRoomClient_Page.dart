import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pgapp/features/admin/presentation/AdminEditClientDetails.dart';

import '../../../core/constants/ColorConstants.dart';
import '../../../core/constants/constants.dart';
import '../../../di/locator.dart';
import '../../../services/dataService/clientService.dart';
import '../utils/adminConstants.dart';

class AdminRoomClientScreen extends StatefulWidget {
  final String roomno;
  final String floorno;
  final bool isAdmin;
  const AdminRoomClientScreen(
      {super.key,
      required this.floorno,
      required this.roomno,
      required this.isAdmin});

  @override
  State<AdminRoomClientScreen> createState() => _AdminRoomClientScreenState();
}

class _AdminRoomClientScreenState extends State<AdminRoomClientScreen> {

  final ClientService _clientService = locator<ClientService>();

  bool isLoading = false;

  List<Map<String, dynamic>>? roomMembers;

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  Future<void> getDataFromDB() async {
    setState(() {
      isLoading = true;
    });
    var res = await _clientService.getClient(widget.floorno, widget.roomno);
    if (res.isNotEmpty) {
      roomMembers = res;
    }
    setState(() {
      isLoading = false;
    });
  }

  Uint8List getImage(String base64Image) {
    // Convert Base64 to an image file
    Uint8List decodedBytes = base64Decode(base64Image);
    return decodedBytes;
  }

  Future<void> _deleteClient(Map<String,dynamic> client) async{
    bool res = await _clientService.deleteClient(client);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Client Deleted Successfully"),
        backgroundColor: Colors.green,
        )
      );
      setState(() {
        roomMembers?.removeWhere((clients) => clients['_id'] == client['_id']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Room No: ${widget.roomno}"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: isLoading
              ? Text("")
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: roomMembers?.length ??
                      0, // You can change this to the number of items you want
                  itemBuilder: (context, index) {
                    final rooms = roomMembers?[index];

                    return ClientViewCard(rooms!);
                  },
                ),
        ),
      ),
    );
  }

  Container ClientViewCard(Map<String, dynamic> room) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.secondary1,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      width: 230,
      height: 150,
      child: testt(room),
    );
  }

  Stack testt(Map<String, dynamic> room) {
    return Stack(
      children: [
        Positioned(
            left: 10,
            top: 10,
            child: Text(
              "${room['name']}",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
        Positioned(
          left: 10,
          top: 40,
          child: Text(
            "${room['mobileno']}",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          left: 220,
          top: 10,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: room['clientimg'] != null
                ? MemoryImage(getImage(room['clientimg']))
                : AssetImage(
                    '$IMG_DIR/homeimg1.png',
                  ) as ImageProvider,
          ),
        ),
        Positioned(
          left: 10,
          top: 70,
          child: Text(
            "DOB: ${room['dob']}",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          left: 10,
          top: 100,
          child: Text(
            "DOJ: ${room['doj']}",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          left: 10,
          top: 130,
          child: Text(
            "Email: ${room['emailaddress']}",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          left: 10,
          top: 160,
          child: Text(
            "Bed: ${room['bed']}",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          left: 10,
          top: 190,
          child: Text(
            "Address: ${room['address']}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Positioned(
          left: 10,
          top: 230,
          child: Text(
            "Adhaar Verified: ${room['adhaarimg'] != null ? "Verified" : "Not Verified"}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        widget.isAdmin
            ? Positioned(
                left: 10,
                top: 280,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AdminEditClientScreen(client: room)));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.primary1),
                  ),
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: CustomColors.secondary1,
                  ),
                ),
              )
            : const Text(""),
        widget.isAdmin
            ? Positioned(
                left: 80,
                top: 280,
                child: IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, room['name'],room);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.primary1),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                    color: CustomColors.secondary1,
                  ),
                ),
              )
            : const Text(""),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String clientName,Map<String,dynamic> client) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $clientName?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteClient(client);
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red button for delete
              ),
            ),
          ],
        );
      },
    );
  }
}




