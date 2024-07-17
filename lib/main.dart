import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resturant_assigment_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Request location permission
  await Permission.location.request();

  runApp(const MainApp());
}
