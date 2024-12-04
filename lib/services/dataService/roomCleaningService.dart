import 'package:pgapp/services/MongoDB.dart';

import '../../features/roomcleaning/model/RoomCleaningModel.dart';

class RoomCleaningService{
  final MongoDBService _mongoDBService;

  RoomCleaningService(this._mongoDBService);

  Future<void> initialize() async {
    // Ensure MongoDB connection is established before performing any operations
    await _mongoDBService.connect();
  }

  //RoomCleaningService Start
  Future<void> saveRoomCleaning(List<RoomCleaning> roomcleaning) async{
    try {
      // Convert RoomCleaning objects to maps
      List<Map<String, dynamic>> roomCleaningsMap =
      roomcleaning.map((roomCleaning) => roomCleaning.toMap()).toList();

      for (var roomCleaningMap in roomCleaningsMap) {
        String day = roomCleaningMap['day']; // The unique identifier (e.g., 'day')

        // Update the document in MongoDB
        var res = await _mongoDBService.roomCleaningCollection.updateOne(
          {'day': day}, // Filter condition (match documents by 'day')
          {
            '\$set': roomCleaningMap, // Fields to update
          },
        );

        // if (res.nModified == 0) {
        //   // If no document matched, you can insert a new one (insert if not found)
        //   await _roomCleaningCollection.insertOne(roomCleaningMap);
        //   print("RoomCleaning for $day was not found, inserted as new");
        // } else {
        //   print("RoomCleaning for $day has been updated");
        // }

      }
    } catch (e) {
      print("Error updating RoomCleaning: $e");
    }
  }

  Future<List<RoomCleaning>> fetchRoomCleanings() async {
    try {
      var result = await _mongoDBService.roomCleaningCollection.find().toList();
      List<RoomCleaning> cleanings = result.map((e) =>
          RoomCleaning(
            e['day'],
            e['isCleaned'],
            e['lastUpdated'] ?? 'Not Updated',
          )).toList();
      return cleanings;
    } catch (e) {
      print("Error fetching RoomCleanings: $e");
      return [];
    }
  }

//RoomCleaningService END

}