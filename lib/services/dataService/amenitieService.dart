import 'package:pgapp/services/MongoDB.dart';

class AmenityService{
  final MongoDBService _mongoDBService;

  AmenityService(this._mongoDBService);

  Future<void> insertAmenitiesData(Map<String, dynamic> data) async {
    try {
      await _mongoDBService.amenitiesCollection.insert(data);
      print("Data inserted: $data");
    } catch (e) {
      print("Error while inserting data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAmenitiesData() async {
    try {
      var data = await _mongoDBService.amenitiesCollection.find().toList();
      return data;
    } catch (e) {
      print("Error while fetching data: $e");
      return [];
    }
  }

}