import 'dart:core';


class ComplaintModel{
  late String roomNo;
  late String complaint;
  late String category;
  late DateTime dateTime;
  late bool isResolved;

  ComplaintModel({
    required this.roomNo,
    required this.complaint,
    required this.category,
    required this.dateTime,
    this.isResolved = false,
  });

  @override
  String toString() {
    return 'Room No: $roomNo, Complaint: $complaint, Category: $category, DateTime: $dateTime';
  }

  Map<String, dynamic> toMap() {
    return {
      'roomNo': roomNo,
      'complaint': complaint,
      'category': category,
      'dateTime': dateTime.toIso8601String(),  // Use ISO format for DateTime
      'isResolved': isResolved,
    };
  }


}