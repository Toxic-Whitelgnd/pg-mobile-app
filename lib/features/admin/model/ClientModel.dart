class ClientModel{
  late String floor;
  late String room;
  late String bed;
  late String sharing;
  late String name;
  late String adharno;
  late String mobileno;
  late String address;
  late String emailaddress;
  late String dob;
  late String rent;
  late String doj;
  late String adhaarImg;
  late String clientImg;

  ClientModel(
      this.floor,
      this.room,
      this.bed,
      this.sharing,
      this.name,
      this.adharno,
      this.mobileno,
      this.address,
      this.emailaddress,
      this.dob,
      this.rent,
      this.doj,
      this.adhaarImg,
      this.clientImg
      );

  @override
  String toString() {
    return 'ClientModel{floor: $floor, room: $room, bed: $bed, sharing: $sharing, name: $name, adharno: $adharno, mobileno: $mobileno, address: $address, emailaddress: $emailaddress, dob: $dob, rent: $rent, doj: $doj}';
  }

  Map<String, dynamic> toMap(){
    return {
      'floor': floor,
      'room': room,
      'bed': bed,
      'sharing': sharing,
      'name': name,
      'adharno': adharno,
      'mobileno': mobileno,
      'address': address,
      'emailaddress': emailaddress,
      'dob': dob,
      'rent': rent,
      'doj': doj,
      'adhaarimg': adhaarImg,
      'clientimg': clientImg,
    };
  }


}