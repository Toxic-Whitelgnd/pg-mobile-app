import 'package:mongo_dart/mongo_dart.dart';
import 'package:pgapp/features/annoucement/model/AnnoucementModel.dart';
import 'package:pgapp/services/MongoDB.dart';

class AnnoucementService {
  final MongoDBService _mongoDBService;

  AnnoucementService(this._mongoDBService);

  Future<bool> addToAnnoucementList(Annoucement a) async {
    try {
      var res = await _mongoDBService.annoucementCollection.insertOne(a.toMap());
      return res.isAcknowledged;
    } catch (e) {
      print("Error at Annoucement Service at adding $e");
      return false;
    }
  }

  Future<List<Annoucement>> getAnnoucements() async {
    try {
      List<Annoucement> ls = [];
      var res = await _mongoDBService.annoucementCollection.find().toList();
      for (var r in res) {
        Annoucement a = Annoucement(
            title: r['title'],
            description: r['description'],
            datetime: r['datetime']);
        ls.add(a);
      }

      return ls;
    } catch (e) {
      print("Error at getting the annoucement $e");
      return [];
    }
  }
  
  Future<bool> updateAnnoucement(Annoucement a) async{
    try{
      var res = await _mongoDBService.annoucementCollection.find({
        'datetime':a.datetime
      }).toList();
      if(res.isNotEmpty){
        var upd = await _mongoDBService.annoucementCollection.updateOne(
          where.eq('datetime', a.datetime), // Match the document with the specific title
          modify
              .set('title', a.title)       // Replace with the new title value
              .set('description', a.description),
        );

        return upd.isAcknowledged;
      }

      return false;
    }catch(e){
      print("Error at updating annoucement $e");
      return false;
    }
  }
}
