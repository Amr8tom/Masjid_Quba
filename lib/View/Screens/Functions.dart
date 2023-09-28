import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



 List<String> get_hours_mins({required String time}){
  String hours="1";
  String mins="0";
  // Split the timeString into hours and minutes
  List<String> Hours_min = time.split(":");

  if(Hours_min.length==2){
   hours=Hours_min[0];
   mins=Hours_min[1];
  }else{
   hours=Hours_min[0];
  }
  return [hours,mins];
}

String getLocalTimeZone() {
 DateTime now = DateTime.now();
 Duration offset = now.timeZoneOffset;
 String sign = offset.isNegative ? '-' : '+';
 int hours = offset.inHours.abs();
 int minutes = (offset.inMinutes.abs() % 60);

 // Format the local time zone in the 'GMT+HH:mm' format
 print("===================================> ${'GMT$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}'}");
 return 'GMT$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

template_triggernotification({
 required int id,
 required int hours ,
 required int mins,
 required String title,
 required String channelKey,
 String? body
}){
 AwesomeNotifications().createNotification(
     content: NotificationContent(
         id: id,
         channelKey: channelKey,
         body:body ?? "Make time for Salah, and Allah will make time for you.",
         title: title,
     ),
     schedule: NotificationCalendar(timeZone: getLocalTimeZone(),year:DateTime.now().year,
      month: DateTime.now().month,
      day: DateTime.now().day,
      hour: hours,
      minute: mins,
     )

 );

}



triggernotification() async{
 String? fajr = await getFajrTime();
 List<String> timesFajr=get_hours_mins(time:fajr?? "1:23");

 template_triggernotification(id: 1,title: "Fajr Time",
     channelKey: "Basic notofications1",
     hours:int.parse(timesFajr[0]) ,mins:int.parse(timesFajr[1]) );

 String? Zuhr = await getZuhrTime();
 List<String> timesZuhr=get_hours_mins(time:Zuhr?? "1:23");

 template_triggernotification(id: 2,title: "Zuhr Time",
     channelKey: "Basic notofications2",
     hours:int.parse(timesZuhr[0]) ,mins:int.parse(timesZuhr[1]) );

 String? Asr = await getAsrTime();
 List<String> TimesAsr=get_hours_mins(time:Asr?? "1:23");

 template_triggernotification(id: 3,title: "Asr Time",
     channelKey: "Basic notofications3",
     hours:int.parse(TimesAsr[0]) ,mins:int.parse(TimesAsr[1]) );

 String? Maghrib = await getMaghribTime();
 List<String> TimesMaghrib=get_hours_mins(time:Maghrib?? "1:23");

 template_triggernotification(id: 4,title: "Maghrib Time",
     channelKey: "Basic notofications4",
     hours:int.parse(TimesMaghrib[0]) ,mins:int.parse(TimesMaghrib[1]) );

 String? Isha = await getIshaTime();
 List<String> TimesIsha=get_hours_mins(time:Isha?? "1:23");

 template_triggernotification(id: 5,title: "Isha Time",
     channelKey: "Basic notofications5",
     hours:int.parse(TimesIsha[0]) ,mins:int.parse(TimesIsha[1]) );

 print("==================>>>>>>>>>>>>>>>>>>>> notification doe");
}



Future<String?> getFajrTime() async {
 final prefs = await SharedPreferences.getInstance();
 return prefs.getString('FajrTime');

}Future<String?> getZuhrTime() async {
 final prefs = await SharedPreferences.getInstance();
 return prefs.getString('ZuhrTime');

}Future<String?> getAsrTime() async {
 final prefs = await SharedPreferences.getInstance();
 return prefs.getString('AsrTime');
}Future<String?> getMaghribTime() async {
 final prefs = await SharedPreferences.getInstance();
 return prefs.getString('MaghribTime');
}Future<String?> getIshaTime() async {
 final prefs = await SharedPreferences.getInstance();
 return prefs.getString('IshaTime');
}
Future<bool?> getisnotified() async {
 final prefs = await SharedPreferences.getInstance();
 return prefs.getBool('isNotofied');
}