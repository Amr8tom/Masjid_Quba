import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../main.dart';
import 'Functions.dart';

bool on_notification=true;

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController textFieldController1 = TextEditingController();
  final TextEditingController textFieldController2 = TextEditingController();
  final TextEditingController textFieldController3 = TextEditingController();
  final TextEditingController textFieldController4 = TextEditingController();
  final TextEditingController textFieldController5 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textFieldController1.dispose();
    textFieldController2.dispose();
    textFieldController3.dispose();
    textFieldController4.dispose();
    textFieldController5.dispose();
    super.dispose();
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(

      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      // Format the selected time as HH:mm
      final formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

      // Set the formatted time to the controller
      controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Notification Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      on_notification ? 'Turn on' : 'Turn off',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Switch(
                      value: on_notification,
                      onChanged: (value) async{
                        setState(() {
                          print("========================>$value");
                          on_notification = value;
                        });
                        final prefs= await SharedPreferences.getInstance();
                        prefs.setBool("isNotofied", on_notification);

                      },
                    ),
                    TextButton(
                        onPressed: ()async{
                      bool? Isnoti =await getisnotified();
                      if (Isnoti==false) {
                        AwesomeNotifications().cancelAll();
                        print("=====================>closed ++++++++++++++++++++");
                      }else{
                        AwesomeNotifications().requestPermissionToSendNotifications();
                        print("===========================> allowed");
                      }

                    }, child:Container(
                        color: Colors.teal,
                        width: 80,
                        height: 21,
                        child: Center(
                          child: Text("Confirm",
                            style: TextStyle(color: Colors.white,),),
                        )))
                  ],
                ),

                buildTimePickerField(
                  textFieldController1,
                  'Fajr',
                  'Enter Fajr time',
                ),
                buildTimePickerField(
                  textFieldController2,
                  'Zuhr',
                  'Enter Zuhr time',
                ),
                buildTimePickerField(
                  textFieldController3,
                  'Asr',
                  'Enter Asr time',
                ),
                buildTimePickerField(
                  textFieldController4,
                  'Maghrib',
                  'Enter Maghrib time',
                ),
                buildTimePickerField(
                  textFieldController5,
                  'Isha',
                  'Enter Isha time',
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, handle the submitted data here
                      final input1 = textFieldController1.text;
                      final input2 = textFieldController2.text;
                      final input3 = textFieldController3.text;
                      final input4 = textFieldController4.text;
                      final input5 = textFieldController5.text;

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('FajrTime', input1);
                      prefs.setString('ZuhrTime', input2);
                      prefs.setString('AsrTime', input3);
                      prefs.setString('MaghribTime', input4);
                      prefs.setString('IshaTime', input5);


                      // Print or use the data as needed
                      print('Input 1: $input1');
                      print('Input 2: $input2');
                      print('Input 3: $input3');
                      print('Input 4: $input4');
                      print('Input 5: $input5');
                      Get.to(MyHomePage(title: "Salah Times",));
                      bool? Isnoti =await getisnotified();
                          if(Isnoti==true) {triggernotification();}
                    }
                  },
                  child: Container(
                    width: 200,
                      height: 30,
                      color: Colors.teal,
                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
                      child: Center(child: Text('Save notifications',style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                      ),))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTimePickerField(
      TextEditingController controller,
      String labelText,
      String hintText,
      ) {
    return Column(
      children: [
        SizedBox(height: 13,),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {
                _selectTime(controller);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $labelText time';
            }
            return null;
          },
        ),
        SizedBox(height: 16,),
      ],
    );
  }
}
