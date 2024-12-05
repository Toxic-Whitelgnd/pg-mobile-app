import 'package:pgapp/services/MongoDB.dart';

import '../../core/constants/constants.dart';
import '../../features/food/model/FoodMenuModel.dart';

class FoodService {
  final MongoDBService _mongoDBService;

  FoodService(this._mongoDBService);

  Future<bool> addFoodItems(List<FoodMenu> foodMenus) async {
    try {
      for(var f in foodMenus){
        print(f.toMap());

        var existingEntry = await _mongoDBService.foodMenuCollection.findOne({'day': f.day});

        if (existingEntry != null) {

          var res = await _mongoDBService.foodMenuCollection.updateOne(
            {'day': f.day},
            {
              '\$set': f.toMap(),
            },
          );

        } else {
          var res = await _mongoDBService.foodMenuCollection.insertOne(f.toMap());
        }
      }

      return true;
    } catch (e) {
      print("Error at saving the food menu $e");

      return false;
    }
  }

  Future<List<FoodMenu>> getFoodMenu() async{
    try{
      List<FoodMenu> fms = [];

      var res = await _mongoDBService.foodMenuCollection.find().toList();
      for(var f in res){

        FoodMenu fm = FoodMenu(
          day: f['day'],
          session1: f['session1'],
          session2: f['session2'],
          session3: f['session3'],
          img: '$IMG_DIR/foodmenu.png',
        );
        fms.add(fm);
      }

      return fms;

    }catch(e){
      print("Error at getting the food $e");

      return [];
    }
  }
}
