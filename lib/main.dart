import 'package:Smart_Home_app/notification_service.dart';
import 'package:Smart_Home_app/screens/main_screen.dart';
import 'package:Smart_Home_app/widgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'accelerometer.dart';
import 'accelerometer_dashboard.dart';
import 'step_count_widget.dart';
import 'google_map_page.dart';
import 'notification_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService.initializeNotifications();
  NotificationService.requestNotificationPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLUTTER APP',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 180, 206, 188),
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'FLUTTER APP'),
      // home: const MainScreen(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    NotificationService.showBasicNotification(
      title: 'Counter Incremented',
      body: 'You have pressed the button $_counter times.',
    );
    // }

    @override
    void initState() {
      super.initState();
      // // Request permission to send notifications if not allowed
      // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      //   if (!isAllowed) {
      //     AwesomeNotifications().requestPermissionToSendNotifications();
      //   }
      // });
    }
  }

  void _navigateToStepCount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StepCountWidget(
          stepCount: _counter, // Pass _counter as stepCount
          onStepSelected: (index) {
            // Handle step selection if needed
          },
        ),
      ),
    );
  }

  void _navigateToGpsTracker() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoogleMapPage(
          stepCount: _counter, // Pass _counter as stepCount
          onStepSelected: (index) {
            // Handle step selection if needed
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // ListTile(
            //   title: const Text('Taken Steps'),
            //   onTap: _navigateToStepCount,
            // ),
            // Add more items to the drawer as needed
            ListTile(
              title: const Text('GP Locator'),
              onTap: _navigateToGpsTracker,
            ),
            ListTile(
              // leading: Icon(Icons.sensor_door_outlined),
              title: Text('Motion Detector'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccelerometerExample(),
                  ),
                );
              },
            ),
            ListTile(
              // leading: Icon(Icons.sensor_door_outlined),
              title: Text('MotionDetector Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccelerometerDashboard(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: DashboardWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
