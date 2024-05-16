// import 'package:fitness_dashboard_ui/model/health_model.dart';

import '../model/health_model.dart';

class HealthDetails {
  final healthData = const [
    HealthModel(
        icon: 'assets/icons/detector.jpg',
        value: "76%",
        title: "Motion Detector"),

    // HealthModel(
    //     icon: 'assets/icons/light.png', value: "7km", title: "Brightness"),
    HealthModel(
        icon: 'assets/icons/light.png', value: "34%", title: "Brightness"),
    HealthModel(
        icon: 'assets/icons/map_maker.jpeg', value: " kG 65 St ", title: "GPS"),
  ];
}
