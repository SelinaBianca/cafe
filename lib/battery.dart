import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class MyHome1Page extends StatefulWidget {
  const MyHome1Page({Key? key}) : super(key: key);

  @override
  State<MyHome1Page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHome1Page> {
  final Battery _battery = Battery();
  int _percentage = 0;
  BatteryState _batteryState = BatteryState.full;
  late StreamSubscription<BatteryState> _streamSubscription;

  @override
  void initState() {
    super.initState();

    // Fetch initial battery state and percentage
    getBatteryState();
    getBatteryPercentage();

    // Set up periodic timer to update battery percentage
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getBatteryPercentage();
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<void> getBatteryPercentage() async {
    final level = await _battery.batteryLevel;
    setState(() {
      _percentage = level;
    });
  }

  void getBatteryState() {
    _streamSubscription = _battery.onBatteryStateChanged.listen((state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Battery Status',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display battery state icon based on state
            Container(
              width: 200,
              height: 200,
              child: BatteryIcon(_batteryState),
            ),
            SizedBox(height: 20),

            // Display battery percentage
            Text(
              'Battery Percentage: $_percentage%',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class BatteryIcon extends StatelessWidget {
  final BatteryState state;

  BatteryIcon(this.state);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (state) {
      case BatteryState.full:
        icon = Icons.battery_full;
        color = Colors.green;
        break;
      case BatteryState.charging:
        icon = Icons.battery_charging_full;
        color = Colors.blue;
        break;
      case BatteryState.discharging:
      default:
        icon = Icons.battery_alert;
        color = Colors.red;
        break;
    }

    return Icon(
      icon,
      size: 50,
      color: color,
    );
  }
}
