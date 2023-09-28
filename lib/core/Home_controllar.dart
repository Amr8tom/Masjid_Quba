import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfriend_1/utils/base_api.dart';
import 'package:webview_flutter/webview_flutter.dart';
class HomeControllar extends GetxController {

  RxInt indx_Web= 0.obs ;

   ChangeWeb(var index){
    indx_Web= RxInt(index);
    update();
   }

  List<String> webs=[
  API.home, API.services,
  API.events, API.announcements,
  API.donate, API.about, API.contact
  ];


  List<BottomNavigationBarItem> bottomsIcons=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.segment_rounded),label: "Services"),
    BottomNavigationBarItem(icon: Icon(Icons.event),label: "Events"),
    BottomNavigationBarItem(icon: Icon(Icons.announcement_outlined),label: "Announcements"),
    BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined),label: "Donate"),
    BottomNavigationBarItem(icon: Icon(Icons.info),label: "About"),
    BottomNavigationBarItem(icon: Icon(Icons.add_ic_call),label: "Contact"),
  ].obs;

}