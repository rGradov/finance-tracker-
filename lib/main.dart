import 'package:finance_tracker/app/ui/my_app/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final MyApp app = MyApp();
  runApp(app);
}
