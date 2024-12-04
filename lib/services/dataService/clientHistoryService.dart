import 'package:pgapp/services/MongoDB.dart';

class ClientHistoryService{
  final MongoDBService _mongoDBService;

  ClientHistoryService(this._mongoDBService);

  Future<List<Map<String,dynamic>>> getClientHistory() async{
    try{
      var res = await _mongoDBService.clientHistoryCollection.find();
      return res.toList();
    }catch(e){
      print("Failed to fetch from the history $e");
      return [];
    }
  }


}