import 'package:flutter/material.dart';



void navigateToPage(BuildContext context, int index) {
  String  page;
  switch (index) {
    case 0:
      page = '/home';
      break;
    case 1:
      page = '/userlist';
      break;
    case 2:
      page = '/fav';
      break;
    default:
      return;
  }
  Navigator.pushReplacementNamed(
      context,
      page
  );
}