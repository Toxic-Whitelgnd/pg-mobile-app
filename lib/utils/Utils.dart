import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/constants/constants.dart';

String dateFormatter(){
  DateTime dt = DateTime.now();
  DateFormat df = DateFormat("dd-MM-yyyy HH:mm");
  String formatedDate = df.format(dt);
  return formatedDate;
}

void CustomToaster(BuildContext context,String text,Color bg,[Color tc = Colors.white]) {
  ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("$text",
        style: TextStyle(
            color: tc
        ),),
        backgroundColor:bg,
      )
  );
}
IconData stringToIcon(String iconName) {
  return iconMap[iconName] ?? Icons.help_outline; // Fallback icon
}
