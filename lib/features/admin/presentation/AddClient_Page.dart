import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pgapp/core/constants/ColorConstants.dart';
import 'package:pgapp/features/admin/model/ClientModel.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../utils/adminConstants.dart';

class AdminAddClientScreen extends StatefulWidget {
  const AdminAddClientScreen({super.key});

  @override
  State<AdminAddClientScreen> createState() => _AdminAddClientScreenState();
}

class _AdminAddClientScreenState extends State<AdminAddClientScreen> {


  String _selectedFloor = floors.first;
  String _selectedRoom = floor1.first;
  String _selectedBed = beds.first;
  String _selectedSharing = sharing.first;

  List<String>? _selectedFloorRooms;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adharNo = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _emailaddress = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _rent = TextEditingController();
  final TextEditingController _doj = TextEditingController();

  MongoDBService _mongoDBService = new MongoDBService();

  // New fields for image picker
  File? _selectedImage;
  File? _selectedClientImage;
  File? _selectedClientCameraImage;
  File? _selectedImageCamera;
  final ImagePicker _imagePicker = ImagePicker();
  String? base64Image;
  String? base64ClientImage;

  bool loading = false;

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

  void _changeRoom(String? room) {
    setState(() {
      _selectedRoom = room!;
    });
  }

  void _changeBed(String? bed) {
    setState(() {
      _selectedBed = bed!;
    });
  }

  void _changeSharing(String? sharing) {
    setState(() {
      _selectedSharing = sharing!;
    });
  }

  Future<void> _onSumbitDetails() async {

    setState(() {
      loading = true;
    });

    ClientModel cm = ClientModel(
        _selectedFloor,
        _selectedRoom,
        _selectedBed,
        _selectedSharing,
        _nameController.text,
        _adharNo.text,
        _mobileNo.text.toString(),
        _address.text,
        _emailaddress.text,
        _dob.text.toString(),
        _rent.text.toString(),
        _doj.text.toString(),
        base64Image.toString(),
        base64ClientImage.toString()
    );

    print(cm.toString());
    bool res = await _mongoDBService.addClient(cm);
    if (res) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Client Added Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      _nameController.clear();
      _doj.clear();
      _dob.clear();
      _rent.clear();
      _emailaddress.clear();
      _address.clear();
      _adharNo.clear();
      _selectedImage = null;
      _mobileNo.clear();
      _selectedClientImage = null;
      _selectedClientCameraImage = null;
     _selectedImageCamera  = null;
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    // Convert image to Base64
    final bytes = await _selectedImage!.readAsBytes();
    base64Image = base64Encode(bytes);

  }

  Future<void> _pickImageCamera() async {
    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImageCamera = File(pickedFile.path);
      });
    }
    // Convert image to Base64
    final bytes = await _selectedImageCamera!.readAsBytes();
    base64Image = base64Encode(bytes);

  }

  Future<void> _pickClientImageCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedClientCameraImage = File(pickedFile.path);
      });
    }
    // Convert image to Base64
    final bytes = await _selectedClientCameraImage!.readAsBytes();
    base64ClientImage = base64Encode(bytes);

  }

  Future<void> _pickClientImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedClientImage = File(pickedFile.path);
      });
    }
    // Convert image to Base64
    final bytes = await _selectedClientImage!.readAsBytes();
    base64ClientImage = base64Encode(bytes);

  }

  @override
  void initState() {
    super.initState();
    _selectedFloorRooms = floor1;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Person"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedFloor,
                      items: floors.map((String f) {
                        return DropdownMenuItem(value: f, child: Text(f));
                      }).toList(),
                      onChanged: _changeFloor,
                    ),
                    const SizedBox(width: 16),
                    DropdownButton(
                      value: _selectedRoom,
                      items: _selectedFloorRooms?.map((String f) {
                        return DropdownMenuItem(value: f, child: Text(f));
                      }).toList(),
                      onChanged: _changeRoom,
                    ),
                    const SizedBox(width: 16),
                    DropdownButton(
                      value: _selectedBed,
                      items: beds.map((String f) {
                        return DropdownMenuItem(value: f, child: Text(f));
                      }).toList(),
                      onChanged: _changeBed,
                    ),
                    const SizedBox(width: 16),
                    DropdownButton(
                      value: _selectedSharing,
                      items: sharing.map((String f) {
                        return DropdownMenuItem(value: f, child: Text(f));
                      }).toList(),
                      onChanged: _changeSharing,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _address,
                  decoration: const InputDecoration(
                    labelText: 'Enter Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _mobileNo,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Enter Mobile No',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailaddress,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Enter EmailAddress',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _dob,
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Enter Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    // Show the date picker
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), // Current date as default
                      firstDate: DateTime(1900), // Earliest selectable date
                      lastDate: DateTime.now(), // Latest selectable date
                    );

                    // Update the TextField value if a date is selected
                    if (selectedDate != null) {
                      _dob.text =
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _adharNo,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Enter Aadhar No',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _rent,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Rent',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _doj,
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'PG Joining',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    // Show the date picker
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), // Current date as default
                      firstDate: DateTime(2024), // Earliest selectable date
                      lastDate: DateTime.now(), // Latest selectable date
                    );

                    // Update the TextField value if a date is selected
                    if (selectedDate != null) {
                      _doj.text =
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    }
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _selectedImageCamera == null ? _pickImage : null,
                  child: const Text("Upload adhaar"),
                ),
                const SizedBox(width: 16),
                _selectedImage != null
                    ? Column(
                      children: [
                        Image.file(
                            _selectedImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedClientImage = null;
                            });
                          },
                          child: Text("x"),
                        )
                      ],
                    )
                    : const Text(""),
                const SizedBox(
                  height: 20,
                  child: Text("or"),
                ),

                ElevatedButton(
                  onPressed: _selectedImage == null ? _pickImageCamera : null,
                  child: const Text("Take Photo"),
                ),
                const SizedBox(height: 20),
                _selectedImageCamera != null
                    ? Column(
                      children: [
                        Image.file(
                            _selectedImageCamera!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImageCamera = null;
                            });
                          },
                          child: Text("x"),
                        )
                      ],
                    )
                    : const Text("No Image Selected"),
                const SizedBox(height: 20),
                // TODO: CLIENT IMAGE BELOW START
                ElevatedButton(
                  onPressed: _selectedClientCameraImage == null
                      ? _pickClientImage
                      : null,
                  child: const Text("Upload Client"),
                ),
                const SizedBox(
                  height: 20,
                  child: Text("or"),
                ),
                _selectedClientImage != null
                    ? Column(
                        children: [
                          Image.file(
                            _selectedClientImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedClientImage = null;
                              });
                            },
                            child: Text("x"),
                          )
                        ],
                      )
                    : const Text(""),
                ElevatedButton(
                  onPressed: _selectedClientImage == null
                      ? _pickClientImageCamera
                      : null,
                  child: const Text("Take Photo"),
                ),
                const SizedBox(width: 16),
                _selectedClientCameraImage != null
                    ? Column(
                        children: [
                          Image.file(
                            _selectedClientCameraImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedClientCameraImage = null;
                              });
                            },
                            child: Text("x"),
                          )
                        ],
                      )
                    : const Text("No Image Selected"),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _onSumbitDetails, child: Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: ADD LOADER while clicking on the button