import 'package:flutter/cupertino.dart';

class HomePageItem{
  final String name;
  final IconData icon;
  final VoidCallback onPressed;

  HomePageItem({
    required this.name,
    required this.icon,
    required this.onPressed
});
}