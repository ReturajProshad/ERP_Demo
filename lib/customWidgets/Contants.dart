import 'package:erp_d_and_a/models/user_model.dart';
import 'package:flutter/material.dart';

class Constants {
  static Constants instances = Constants();

  List<Color> AppbarColorLight = [
    Colors.red,
    Colors.blue,
  ];
  List<Color> splashScreenColor = [
    Colors.blueAccent,
    const Color.fromARGB(171, 255, 255, 255),
    Colors.blueAccent
  ];

  //Hive Constants
  String userBox = 'userBox';

  //firebase and role constants
  String Users = "Users";

  String admin = "Admin";
  String employee = "Employee";
  //Dashboard Constants
  String hr = "HR";
  String finance = "Finance";
  String inventory = "Inventory";

  //updated role
  late String currentRole;
  late UserModel currentUser;

  //Dropdown items
  List<String> dropDownitems = ["Admin", "HR", "Finance", "Employee"];
}
