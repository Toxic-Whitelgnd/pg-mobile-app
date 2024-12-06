import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:pgapp/features/complaints/model/ComplaintModel.dart';
import 'package:pgapp/features/roomcleaning/model/RoomCleaningModel.dart';

import '../core/constants/DatabaseConstants.dart';
import '../features/admin/model/ClientModel.dart';

class MongoDBService {
  static final MongoDBService _instance =
      MongoDBService._internal(); //implementation of singleton pattern
  late Db _db;

  late DbCollection _amenitiesCollection;
  late DbCollection _complaintCollection;
  late DbCollection _clientCollection;
  late DbCollection _clientHistoryCollection;
  late DbCollection _roomCleaningCollection;
  late DbCollection _foodmenuCollection;
  late DbCollection _announcementColelction;

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

      // Initialize collections after connection

      _amenitiesCollection = _db.collection(MONGO_AMENITIES_COLLECTION);
      _complaintCollection = _db.collection(MONGO_COMPLAINTS_COLLECTION);
      _clientCollection = _db.collection(MONGO_CLIENT_COLLECTION);
      _clientHistoryCollection = _db.collection(MONGO_CLIENTHISTORY_COLLECTION);
      _roomCleaningCollection = _db.collection(MONGO_ROOMCLEANING_COLLECTION);
      _foodmenuCollection = _db.collection(MONGO_FOODMENU_COLLECTION);
      _announcementColelction = _db.collection(MONGO_ANNOUCMENT_COLLECTION);

      //End of Initaliztion

    } catch (e) {
      print("Error while connecting to MongoDB: $e");
    }
  }

  DbCollection get amenitiesCollection => _amenitiesCollection;
  DbCollection get complaintCollection => _complaintCollection;
  DbCollection get clientCollection => _clientCollection;
  DbCollection get clientHistoryCollection => _clientHistoryCollection;
  DbCollection get roomCleaningCollection => _roomCleaningCollection;
  DbCollection get foodMenuCollection => _foodmenuCollection;
  DbCollection get annoucementCollection => _announcementColelction;

  Future<void> close() async {
    try {
      await _db.close();
      print("MongoDB connection closed");
    } catch (e) {
      print("Error while closing MongoDB connection: $e");
    }
  }
}
