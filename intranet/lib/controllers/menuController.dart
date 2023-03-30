// ignore_for_file: file_names

import 'package:get/get.dart';


class MenuControllers extends GetxController {
  final RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;
  List<String> get menuItems =>
      ["Home", "Recursos Humanos", "ICT", "Jira", "Webmail", "AppMe"];

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
  }
}