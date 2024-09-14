import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/Dashbord/dashbord.dart';
import 'package:ticketbooking/mainscreens/menu/menu.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/changepassword.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/profile.dart';
import 'package:ticketbooking/onbording/login.dart';
import 'package:ticketbooking/onbording/registration.dart';
import 'package:ticketbooking/onbording/splashcreen.dart';

void main() {
  runApp(const MyApp());
  _requestPermissions();
  initNotifications();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: ScreenSizeConfig.primarycolor,
          )),
      home:
      // loginpage()
      // Registration()
      //BottomNavigationBarWidget()
      Splashcreen(),
    );
  }
}
Future<void> initNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> _requestPermissions() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await initNotifications();
//   runApp(const MyApp());

// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home:  MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
// Future<void> initNotifications() async {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }
// class MyHomePage extends StatefulWidget {
//    MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> showWelcomeNotification() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     // Increment the installation counter
//     int installationCount = (prefs.getInt('installation_count') ?? 0) + 1;
//     prefs.setInt('installation_count', installationCount);

//     // Check if it's the first installation for this user
//     if (installationCount == 1) {
//       // Show welcome notification
//       await _showWelcomeNotification();
//     }
//   }

//   Future<void> _showWelcomeNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'welcomebro', // Change this to a unique channel ID
//       'Welcome Notification',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'Welcome to My App!', // Notification title
//       'Thank you for installing our app. Enjoy exploring!', // Notification body
//       platformChannelSpecifics,
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     showWelcomeNotification();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }