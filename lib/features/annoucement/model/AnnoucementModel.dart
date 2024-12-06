class Annoucement {
  late String title;
  late String description;
  late String datetime;

  Annoucement({
    required this.title,
    required this.description,
    required this.datetime
  });


  @override
  String toString() {
    return 'Annoucement{title: $title, description: $description, datetime: $datetime}';
  }

  Map<String,dynamic> toMap(){
    return {
      'title': this.title,
      'description': this.description,
      'datetime': this.datetime
    };
  }
}
