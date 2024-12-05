import 'package:get_it/get_it.dart';
import 'package:pgapp/services/MongoDB.dart';
import 'package:pgapp/services/dataService/amenitieService.dart';
import 'package:pgapp/services/dataService/clientHistoryService.dart';
import 'package:pgapp/services/dataService/clientService.dart';
import 'package:pgapp/services/dataService/complaintService.dart';
import 'package:pgapp/services/dataService/foodService.dart';

import '../services/dataService/roomCleaningService.dart';

final GetIt locator = GetIt.instance;


Future<void> setupLocator() async{
  final MongoDBService mongoDBService = MongoDBService();
  await mongoDBService.connect(); //used to connect to DB
  locator.registerSingleton<MongoDBService>(mongoDBService);

  //Register All Service here
  locator.registerSingleton<RoomCleaningService>(
    RoomCleaningService(locator<MongoDBService>()
    ),
  );

  locator.registerSingleton<ClientHistoryService>(
    ClientHistoryService(locator<MongoDBService>()),
  );

  locator.registerSingleton<ClientService>(
    ClientService(locator<MongoDBService>()),
  );

  locator.registerSingleton<ComplaintService>(
    ComplaintService(locator<MongoDBService>()),
  );

  locator.registerSingleton<AmenityService>(
    AmenityService(locator<MongoDBService>()),
  );

  locator.registerSingleton(
    FoodService(locator<MongoDBService>()),
  );
}