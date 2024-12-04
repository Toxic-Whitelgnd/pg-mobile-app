import 'package:intl/intl.dart';
import 'RoomCleaningModel.dart';

class RoomCleanService {
  List<RoomCleaning> roomCleaned = [];
  DateTime? lastResetDate;

  void addToRoomClean(RoomCleaning r) {
    // _checkAndResetList();
    if(r.isCleaned){
      DateTime now = DateTime.now();
      var lastUpdt = DateFormat('MMM d').format(now);
      r.lastUpdated = lastUpdt;
    }
    roomCleaned.add(r);
  }

  List<RoomCleaning> getRoomClean() {
    // _checkAndResetList();
    return roomCleaned;
  }

  void _checkAndResetList() {
    DateTime now = DateTime.now();

    // If `lastResetDate` is null, set it to the current Monday
    if (lastResetDate == null) {
      lastResetDate = _getMondayOfWeek(now);
    }

    // Check if we're in a new week
    DateTime currentMonday = _getMondayOfWeek(now);
    if (currentMonday.isAfter(lastResetDate!)) {
      roomCleaned.clear(); // Reset the list
      lastResetDate = currentMonday; // Update the reset date
    }
  }

  // Helper method to get the Monday of the current week
  DateTime _getMondayOfWeek(DateTime date) {
    int daysToSubtract = date.weekday - 1; // Monday is 1
    return date.subtract(Duration(days: daysToSubtract));
  }
}
