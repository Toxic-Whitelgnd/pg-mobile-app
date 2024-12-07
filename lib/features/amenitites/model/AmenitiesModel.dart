import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../admin/utils/amenities.dart';

class Amenities{
  late String name;
  late String icon;
  late bool enabled;

  Amenities(this.name, this.icon, this.enabled);

  @override
  String toString() {
    return 'Amenities{name: $name, icon: $icon, enabled: $enabled}';
  }

  Map<String,dynamic> toMap(){
    return {
      'name': this.name,
      'icon': this.icon,
      'enabled': this.enabled
    };
  }

}