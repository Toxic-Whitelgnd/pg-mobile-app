import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgapp/core/constants/constants.dart';
import 'package:pgapp/di/locator.dart';
import 'package:pgapp/features/admin/utils/amenities.dart';
import 'package:pgapp/services/dataService/amenitieService.dart';
import 'package:pgapp/utils/Utils.dart';

import '../../amenitites/model/AmenitiesModel.dart';

class AmenitiesAdminScreen extends StatefulWidget {
  const AmenitiesAdminScreen({super.key});

  @override
  State<AmenitiesAdminScreen> createState() => _AmenitiesAdminScreenState();
}

class _AmenitiesAdminScreenState extends State<AmenitiesAdminScreen> {

  final AmenityService _amenityService = locator<AmenityService>();

  final AmenitiesList as = AmenitiesList();
  List<Amenities>? amenities ;

  @override
  void initState() {
    super.initState();
    // amenities = as.amenities;
    getAmenities();
  }

  Future<void> getAmenities() async{
    var res = await _amenityService.getAmenitiesData();
    if(res.isNotEmpty){
      setState(() {
        amenities = res;
      });

    }
  }

  Future<void> saveAmenities() async{
    // Handle the save logic here, e.g., saving selected amenities to the database
    final selectedAmenities =
        amenities?.where((amenity) => amenity.enabled).toList();

    bool res = await  _amenityService.insertAmenitiesData(amenities!);
    if(res){
      CustomToaster(context, "Amenities saved Successfully", Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Amenities"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: amenities == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: amenities!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(iconMap[amenities![index].icon]),
                          title: Text(amenities![index].name),
                          trailing: Checkbox(
                            value: amenities![index].enabled,
                            onChanged: (bool? value) {
                              setState(() {
                                amenities![index].enabled = value ?? false;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: saveAmenities,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
