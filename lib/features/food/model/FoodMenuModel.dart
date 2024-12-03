class FoodMenu {
  late String day;
  late String session1;
  late String session2;
  late String session3;
  late String img;



  // Constructor
  FoodMenu({
    required this.day,
    required this.session1,
    required this.session2,
    required this.session3,
    required this.img,
  });

  @override
  String toString() {
    return 'FoodMenu{day: $day, session1: $session1, session2: $session2, session3: $session3, img: $img}';
  }



  Map<String, dynamic> toMap() {
    return {
      'day': this.day,
      'session1': this.session1,
      'session2': this.session2,
      'session3': this.session3,
      'img': this.img,
    };
  }
}
