import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../utils/adminConstants.dart';

class AdminEditClientScreen extends StatefulWidget {
  final Map<String, dynamic> client;
  const AdminEditClientScreen({super.key, required this.client});

  @override
  State<AdminEditClientScreen> createState() => _AdminEditClientScreenState();
}

class _AdminEditClientScreenState extends State<AdminEditClientScreen> {

  late final TextEditingController nameController;
  late final TextEditingController adharnoController;
  late final TextEditingController mobilenoController;
  late final TextEditingController addressController;
  late final TextEditingController emailaddressController;
  late final TextEditingController dobController;
  late final TextEditingController rentController;
  late final TextEditingController dojController;

  // Variables for dropdown selections
  String? selectedFloor;
  String? selectedRoom;
  String? selectedBed;
  String? selectedSharing;

  // Sample dropdown options
  final List<String> floorOptions = floors;
  final List<String> roomOptions = floor1;
  final List<String> bedOptions = beds;
  final List<String> sharingOptions = sharing;

  List<String>? _selectedFloorRooms;

  MongoDBService _mongoDBService = new MongoDBService();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.client['name']);
    adharnoController = TextEditingController(text: widget.client['adharno']);
    mobilenoController = TextEditingController(text: widget.client['mobileno']);
    addressController = TextEditingController(text: widget.client['address']);
    emailaddressController =
        TextEditingController(text: widget.client['emailaddress']);
    dobController = TextEditingController(text: widget.client['dob']);
    rentController = TextEditingController(text: widget.client['rent']);
    dojController = TextEditingController(text: widget.client['doj']);

    // Preload dropdown selections
    selectedFloor = widget.client['floor'];
    selectedRoom = widget.client['room'];
    selectedBed = widget.client['bed'];
    selectedSharing = widget.client['sharing'];
    _selectedFloorRooms = floor1;
  }

  @override
  void dispose() {

    nameController.dispose();
    adharnoController.dispose();
    mobilenoController.dispose();
    addressController.dispose();
    emailaddressController.dispose();
    dobController.dispose();
    rentController.dispose();
    dojController.dispose();
    super.dispose();
  }

  Future<void> saveClientDetails() async{
    final updatedClient = {
      '_id': widget.client['_id'],
      'floor': selectedFloor,
      'room': selectedRoom,
      'bed': selectedBed,
      'sharing': selectedSharing,
      'name': nameController.text,
      'adharno': adharnoController.text,
      'mobileno': mobilenoController.text,
      'address': addressController.text,
      'emailaddress': emailaddressController.text,
      'dob': dobController.text,
      'rent': rentController.text,
      'doj': dojController.text,
    };
    // Save logic (e.g., API call)
    print("Updated Client Details: $updatedClient");

    bool res = await _mongoDBService.updateClient(updatedClient);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Client updated Successfully"),
        backgroundColor: Colors.green,
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Client updation failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _changeFloor(String? floor) {
    setState(() {
      selectedFloor = floor!;
    });
    switch (selectedFloor) {
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

    selectedRoom = _selectedFloorRooms!.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Client"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("edit the client details here ${widget.client['name']}"),
              const SizedBox(height: 10),
              _buildDropdown("Floor", floorOptions, selectedFloor, _changeFloor),
              _buildDropdown("Room", _selectedFloorRooms!, selectedRoom, (value) {
                setState(() {
                  selectedRoom = value;
                });
              }),
              _buildDropdown("Bed", bedOptions, selectedBed, (value) {
                setState(() {
                  selectedBed = value;
                });
              }),
              _buildDropdown("Sharing", sharingOptions, selectedSharing, (value) {
                setState(() {
                  selectedSharing = value;
                });
              }),
              _buildTextField("Name", nameController),
              _buildTextField("Aadhar No", adharnoController),
              _buildTextField("Mobile No", mobilenoController),
              _buildTextField("Address", addressController),
              _buildTextField("Email Address", emailaddressController),
              _buildTextField("DOB", dobController),
              _buildTextField("Rent", rentController),
              _buildTextField("DOJ", dojController),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: saveClientDetails,
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
