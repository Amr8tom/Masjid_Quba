import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/themes/theme.dart';
import 'utils/Firebase_api.dart';
import 'package:cron/cron.dart';
import 'View/Screens/Functions.dart';
import 'package:get/get.dart';
import 'package:myfriend_1/core/Home_controllar.dart';
import 'View/Screens/Times.dart';
import 'View/Widgets.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAPI().intnotifiactions();
  AwesomeNotifications().initialize(null,Channels,debug: true);
  final Future<bool?> Isnoti =  getisnotified();
  if(Isnoti==true) {
    var cron = Cron().schedule(Schedule.parse(' 0 0 6 * * *'), () {
      triggernotification();
      print("============================>>  yarab");
    });
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masjid Quba',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        bottomNavigationBarTheme:Themee.NavbarTheme,
      ),
      home: const MyHomePage(title: 'Masjid Quba'),
      initialBinding: BindingsBuilder((){
        Get.put(HomeControllar());

      }),
    );
  }
}


class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}
class _MyHomePageState extends State<MyHomePage> {
  @override

  // final HomeControllar homeccontrollar = Get.find<HomeControllar>();
  void initState() {
    final Future<bool?> Isnoti =  getisnotified();
    if(Isnoti==true) {
      AwesomeNotifications().isNotificationAllowed().then((value) {
        if (!value) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    Get.put(HomeControllar());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:Colors.teal ,
        title: Text(
          "Masjid Quba",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: GetBuilder(
        init: HomeControllar(),
              builder: (controller) => WebView(
                key: UniqueKey(), // Use a UniqueKey here
                javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
                initialUrl: controller.webs[controller.indx_Web.value], // Your URL logic here
              ),
      )
      ,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child:Icon(Icons.settings,)
          ,onPressed: () {
        Get.to(InputScreen());

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => InputScreen()));
          }),
      bottomNavigationBar:GetBuilder(
        init: HomeControllar(),
            builder: (controller)=>BottomNavigationBar(
        backgroundColor: Colors.teal,
          onTap: (index){
          try{controller.ChangeWeb(index);
          }catch(e){print("===================================>$e");}
          },
          currentIndex:controller.indx_Web.value,
          items:controller.bottomsIcons,
        ),


    ));
  }
}
