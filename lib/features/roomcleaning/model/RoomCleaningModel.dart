class RoomCleaning{
  late String day;
  late bool isCleaned;
  String lastUpdated = '';

  RoomCleaning(this.day, this.isCleaned);

  @override
  String toString() {
    return 'RoomCleaning{day: $day, isCleaned: $isCleaned}';
  }

  Map<String,dynamic> toMap(){
    return {
      'day':this.day,
      'isCleaned':this.isCleaned,
      'lastUpdated':this.lastUpdated,
    };
  }

}