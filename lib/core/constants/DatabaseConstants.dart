import 'package:flutter_dotenv/flutter_dotenv.dart';

final mongouser = dotenv.env['MONGOUSERNAME'];
final password = dotenv.env['MONGOPASSWORD'];

final MONGO_URL = "mongodb+srv://${mongouser}:${password}@cluster0.p66uz.mongodb.net/PG?retryWrites=true&w=majority&appName=Cluster0";
const MONGO_AMENITIES_COLLECTION = "amenities";
const MONGO_COMPLAINTS_COLLECTION = "complaints";
const MONGO_CLIENT_COLLECTION = "client";
const MONGO_CLIENTHISTORY_COLLECTION = "clientHistory";
const MONGO_ROOMCLEANING_COLLECTION = "roomcleaning";
const MONGO_FOODMENU_COLLECTION = "foodmenu";
const MONGO_ANNOUCMENT_COLLECTION = "annoucement";