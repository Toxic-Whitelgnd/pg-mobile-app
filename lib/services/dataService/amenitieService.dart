import 'package:mongo_dart/mongo_dart.dart';
import 'package:pgapp/features/amenitites/model/AmenitiesModel.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../../utils/Utils.dart';

class AmenityService {
  final MongoDBService _mongoDBService;

  AmenityService(this._mongoDBService);

  Future<bool> insertAmenitiesData(List<Amenities> data) async {
    try {
      for (var a in data) {
        var res =
            await _mongoDBService.amenitiesCollection.findOne({'name': a.name});
        if (res != null) {
          //Update
          var res3 = await _mongoDBService.amenitiesCollection.updateOne(
              where.eq('name', a.name), modify.set('enabled', a.enabled));
        } else {
          //Insert
          var res2 =
              await _mongoDBService.amenitiesCollection.insert(a.toMap());
        }
      }

      return true;
    } catch (e) {
      print("Error while inserting data: $e");
      return false;
    }
  }

  Future<List<Amenities>> getAmenitiesData() async {
    try {
      var data = await _mongoDBService.amenitiesCollection.find().toList();
      List<Amenities> ls = [];
      for (var a in data) {
        var ar = Amenities(
            a['name'],
            a['icon'],
            a['enabled']
        );
        ls.add(ar);
      }
      return ls;
    } catch (e) {
      print("Error while fetching data: $e");
      return [];
    }
  }
}
