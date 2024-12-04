import 'package:mongo_dart/mongo_dart.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../../features/complaints/model/ComplaintModel.dart';

class ComplaintService{
  final MongoDBService _mongoDBService;

  ComplaintService(this._mongoDBService);


  Future<bool> postRaiseComplaints(ComplaintModel complaintModel) async {
    try {
      var complaintMap = complaintModel.toMap();
      await _mongoDBService.complaintCollection.insert(complaintMap);
      return true;
    } catch (e) {
      print("Error while posting the data: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getComplaints() async {
    try {
      var data = await _mongoDBService.complaintCollection.find().toList();
      print(data);
      return data;
    } catch (e) {
      print("Error while fetching data: $e");
      return [];
    }
  }

  Future<bool> changeStatus(ObjectId complaintId) async {
    try {
      final result = await _mongoDBService.complaintCollection.updateOne(
          where.eq('_id', complaintId), modify.set('isResolved', true));
      return result.isAcknowledged && result.nModified > 0;
    } catch (e) {
      print("Error on Changing Status: $e");
      return false;
    }
  }

}