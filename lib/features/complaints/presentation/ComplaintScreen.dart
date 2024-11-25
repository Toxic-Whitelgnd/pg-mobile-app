import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../model/ComplaintModel.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _multiLineController = TextEditingController();
  DateTime currentDateTime = DateTime.now();

  MongoDBService _mongoDBService = MongoDBService();

  String _roomNo = "";
  String _complaint = "";

  String _selectedItem = 'Bathroom';
  final List<String> _dropdownItems = [
    'Bathroom',
    'Room',
    'Outdoor',
    'Food',
    'Parking',
    'Washing Machine',
    'Water'
  ];

  void _sumbitComplaintDetails() async{
    if (_roomController.text.trim().isEmpty) {
      // Show a SnackBar error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Room number cannot be empty!'),
          backgroundColor: Colors.red, // Optional: change the background color
        ),
      );
      return; // Exit the method to prevent further execution
    }

    setState(() {
      _roomNo = _roomController.text;
      _complaint = _multiLineController.text;
    });

    ComplaintModel complaintModel = ComplaintModel(
        roomNo: _roomNo,
        complaint: _complaint,
        category: _selectedItem,
        dateTime: currentDateTime);

    print(complaintModel.toString());
    //make a call to the mongodb service
    bool res = await _mongoDBService.postRaiseComplaints(complaintModel);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complaint raised Successfully!'),
          backgroundColor: Colors.green, // Optional: change the background color
        ),
      );

      _roomController.clear();
      _multiLineController.clear();

    }
  }

  void _onDropdownChanged(String? newValue) {
    setState(() {
      _selectedItem = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raise Your Complaints"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _roomController,
                decoration: const InputDecoration(
                  labelText: 'Enter Room No',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedItem, // The currently selected item
                onChanged:
                    _onDropdownChanged, // Function called when selection changes
                items: _dropdownItems.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item, // The value of the item
                    child: Text(item), // The displayed widget
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Multi-line TextField
              TextField(
                controller: _multiLineController,
                maxLines: 5, // Set the number of lines
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter multi-line text',
                  hintText: 'Type your message here...',
                ),
              ),
              const SizedBox(height: 20),
              // Button to trigger the input handling
              ElevatedButton(
                onPressed: _sumbitComplaintDetails,
                child: const Text('Sumbit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
