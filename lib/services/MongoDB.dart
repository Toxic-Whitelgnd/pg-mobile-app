import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:pgapp/features/complaints/model/ComplaintModel.dart';

import '../core/constants/DatabaseConstants.dart';
import '../features/admin/model/ClientModel.dart';

class MongoDBService {
  static final MongoDBService _instance =
      MongoDBService._internal(); //implementation of singleton pattern
  late Db _db;
  late DbCollection _amenitiesCollection;
  late DbCollection _complaintCollection;
  late DbCollection _clientCollection;

  // Private constructor for singleton
  MongoDBService._internal();

  // Factory to return the singleton instance
  factory MongoDBService() => _instance;

  Future<void> connect() async {
    try {
      _db = await Db.create(MONGO_URL);
      await _db.open();
      print("Connected to MongoDB");
      var db = await _db.listDatabases();
      print(db);
      // Initialize collections after connection
      _amenitiesCollection = _db.collection(MONGO_AMENITIES_COLLECTION);
      _complaintCollection = _db.collection(MONGO_COMPLAINTS_COLLECTION);
      _clientCollection = _db.collection(MONGO_CLIENT_COLLECTION);
    } catch (e) {
      print("Error while connecting to MongoDB: $e");
    }
  }

  DbCollection get amenitiesCollection => _amenitiesCollection;
  DbCollection get complaintCollection => _complaintCollection;
  DbCollection get clientCollection => _clientCollection;

  //Amenities Start
  Future<void> insertAmenitiesData(Map<String, dynamic> data) async {
    try {
      await _amenitiesCollection.insert(data);
      print("Data inserted: $data");
    } catch (e) {
      print("Error while inserting data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAmenitiesData() async {
    try {
      var data = await _amenitiesCollection.find().toList();
      return data;
    } catch (e) {
      print("Error while fetching data: $e");
      return [];
    }
  }

  //Amenities End

  //REGION:Complaint Service
  Future<bool> postRaiseComplaints(ComplaintModel complaintModel) async {
    try {
      var complaintMap = complaintModel.toMap();
      await _complaintCollection.insert(complaintMap);
      return true;
    } catch (e) {
      print("Error while posting the data: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getComplaints() async {
    try {
      var data = await _complaintCollection.find().toList();
      print(data);
      return data;
    } catch (e) {
      print("Error while fetching data: $e");
      return [];
    }
  }

  Future<bool> changeStatus(ObjectId complaintId) async {
    try {
      final result = await _complaintCollection.updateOne(
          where.eq('_id', complaintId), modify.set('isResolved', true));
      return result.isAcknowledged && result.nModified > 0;
    } catch (e) {
      print("Error on Changing Status: $e");
      return false;
    }
  }

  //REGIONEND: Complaint End

  //AddClient
  Future<bool> addClient(ClientModel cm) async{
    try{
      var data = cm.toMap();
      await _clientCollection.insert(data);
      return true;
    }catch(e){
      print("Error on client adding: $e");
      return false;
    }
  }

  Future<void> close() async {
    try {
      await _db.close();
      print("MongoDB connection closed");
    } catch (e) {
      print("Error while closing MongoDB connection: $e");
    }
  }
}
