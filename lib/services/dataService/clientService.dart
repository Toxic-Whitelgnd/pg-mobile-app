import 'package:mongo_dart/mongo_dart.dart';
import 'package:pgapp/services/MongoDB.dart';

import '../../features/admin/model/ClientModel.dart';

class ClientService{
  final MongoDBService _mongoDBService;
  
  ClientService(this._mongoDBService);

  //AddClient
  Future<bool> addClient(ClientModel cm) async{
    try{
      var data = cm.toMap();
      await _mongoDBService.clientCollection.insert(data);
      return true;
    }catch(e){
      print("Error on client adding: $e");
      return false;
    }
  }

  Future<List<Map<String,dynamic>>> getClient(String floorno,String roomno) async{
    try{
      var data = await _mongoDBService.clientCollection.find(where.eq('room', roomno)).toList();
      return data;

    }catch (e){
      print("Error on client adding: $e");
      return [];
    }
  }

  Future<bool> updateClient(Map<String,dynamic> client) async{
    try{
      print(client);
      final ObjectId clientid = client['_id'];
      final update = {
        r'$set':{
          'floor':client['floor'],
          'room':client['room'],
          'bed': client['bed'],
          'sharing': client['sharing'],
          'name': client['name'],
          'adharno': client['adharno'],
          'mobileno': client['mobileno'],
          'address': client['address'],
          'emailaddress': client['emailaddress'],
          'dob': client['dob'],
          'rent': client['rent'],
          'doj': client['doj'],
        }
      };
      var res = await _mongoDBService.clientCollection.updateOne(where.eq('_id', clientid), update);
      return res.isAcknowledged && res.nModified > 0;
    }
    catch(e){
      print("Error on client Updation: $e");
      return false;
    }
  }

  Future<bool> deleteClient(Map<String,dynamic> client) async{
    try{
      bool history = await SaveHistoryDetails(client);
      if(history){
        var res = await _mongoDBService.clientCollection.deleteOne(where.eq('_id', client['_id']));
        return res.isAcknowledged;
      }

      return false;
    }catch(e){
      print("Failed to delete clientId $e");
      return false;
    }
  }

  Future<bool> SaveHistoryDetails(Map<String,dynamic> client) async{
    try{
      client['dol'] = DateTime.now().toIso8601String();
      var res = await _mongoDBService.clientHistoryCollection.insert(client);
      print("Saved to History");
      return res.isNotEmpty;
    }catch(e){
      print("Failed to Save in the history $e");
      return false;
    }
  }

//Addcleint end
}