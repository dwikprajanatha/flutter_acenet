import 'dart:convert';
import 'dart:io';

import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:acenet_project/models/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var loading = true;
  JobDoneCount jobCount = JobDoneCount();
  List list = new List<SpkDetail>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final scaffoldState = GlobalKey<ScaffoldState>();
  final firebaseMessaging = FirebaseMessaging();
  final controllerTopic = TextEditingController();
  bool isSubscribed = false;
  String token = '';

  Future<dynamic> showNotificationForeground(
      Map<String, dynamic> message) async {
    String title = "";
    String body = "";

    try {
      final dynamic notification = message['data'] ?? message;
      print(notification);
      title = notification['title'];
      body = notification['body'];

      print(title);
      print(body);

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'channel-fcm', 'Notification', 'Push Notification',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0, title, body, platformChannelSpecifics);
    } catch (e) {
      print("ERROR : ");
      print(e);
    }
  }

  initLocalNotification() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String dataJSON) async {
    Navigator.pushNamed(context, "/upcoming");
  }

  void getDataFcm(Map<String, dynamic> message) {
    String name = '';
    String age = '';
    if (Platform.isIOS) {
    } else if (Platform.isAndroid) {
      var data = message['data'];
    }
    if (name.isNotEmpty && age.isNotEmpty) {
      setState(() {});
    }
    debugPrint('getDataFcm: name: $name & age: $age');
  }

  initFcm() {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotificationForeground(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final dynamic data = message['data'] ?? message;
        Navigator.pushNamed(context, "/upcoming");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final dynamic data = message['data'] ?? message;
        Navigator.pushNamed(context, "/upcoming");
      },
      onBackgroundMessage: onBackgroundMessageHandler,
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
  }

  static Future<dynamic> onBackgroundMessageHandler(Map<String, dynamic> message) async{
    print("onBackgroundMessage : $message");
    // _HomePageState().showNotificationForeground(message);

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel-fcm', 'Notification', 'Push Notification',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message['data']['title'], message['data']['body'], platformChannelSpecifics);


// return null;
  }

  _getJobCount() async {
    // list.clear();

    await ApiServices().getJobCounting().then((value) {
      setState(() {
        jobCount = value;
        loading = false;
      });
    });
  }

  _getTodayTask() async {
    // list.clear();

    await ApiServices().getSPK().then((value) {
      setState(() {
        list = value;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initFcm();

    initLocalNotification();

    _getJobCount();
    _getTodayTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await _getJobCount();
            await _getTodayTask();
          },
          child: ListView(
            children: <Widget>[
              // JOB COUNT //
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 8.0),
                child: Text(
                  "Job Count",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: JobCountCard("This Week",
                          jobCount != null ? jobCount.weekly_count : 0)),
                  Flexible(
                      fit: FlexFit.tight,
                      child: JobCountCard("This Month",
                          jobCount != null ? jobCount.monthly_count : 0)),
                ],
              ),
              // TODAY TASK //
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 15.0, 0, 10.0),
                child: Text(
                  "Today Task",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : list.length > 0
                      ? Column(
                          children: list.map((data) {
                            return CardLayout(
                              pekerjaan: data.ket_pekerjaan,
                              waktu: data.jam_mulai,
                              pelanggan: data.nama,
                              idPekerjaan: (data.id),
                            );
                          }).toList(),
                        )
                      : Center(
                          child: Text("No Task for Today."),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}


class CardLayout extends StatelessWidget {
  String waktu, pekerjaan, pelanggan;
  int idPekerjaan;

  CardLayout(
      {@required this.waktu,
      @required this.pekerjaan,
      @required this.idPekerjaan,
      @required this.pelanggan});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed('/detailPekerjaan', arguments: idPekerjaan),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 25.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(waktu),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 2.0,
                    indent: 2.0,
                    endIndent: 2.0,
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.work,
                          size: 25.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              pekerjaan,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 2.0,
                    indent: 2.0,
                    endIndent: 2.0,
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 25.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              pelanggan,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobCountCard extends StatelessWidget {
  String label = "";
  int count = 0;
  JobCountCard(this.label, this.count);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(
              "Work Done",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            Text(count != null && count != "null" ? count.toString() : "-",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500)),
            Text(label,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
