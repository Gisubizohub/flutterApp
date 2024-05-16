import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';

class Light extends StatefulWidget {
  Light({Key? key}) : super(key: key);
  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light> {
  double brightness = 0.0;
  bool toggle = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getBrightness();
  }

  Future<void> getBrightness() async {
    double bright;
    try {
      bright = await FlutterScreenWake.brightness;
    } on PlatformException {
      bright = 1.0;
    }
    if (!mounted) return;

    setState(() {
      brightness = bright;
    });
  }

  String brightnessPercentage() {
    int percentage = (brightness * 100).round();
    return '$percentage%';
  }

  void showBrightnessNotification() {
    final snackBar = SnackBar(
      content: Text('Brightness set to ${brightnessPercentage()}'),
      duration: const Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Light Sensor'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(color: Colors.black26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedCrossFade(
                firstChild: const Icon(Icons.brightness_7, size: 50),
                secondChild: const Icon(Icons.brightness_3, size: 50),
                crossFadeState: toggle
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(seconds: 1),
              ),
              Expanded(
                child: Slider(
                  value: brightness,
                  onChanged: (value) {
                    setState(() {
                      brightness = value;
                      FlutterScreenWake.setBrightness(brightness);
                      if (brightness == 0) {
                        toggle = true;
                      } else {
                        toggle = false;
                      }
                    });
                    showBrightnessNotification(); // Call the notification function
                  },
                ),
              ),
              Text(brightnessPercentage()),
            ],
          ),
        ),
      ),
    );
  }
}
