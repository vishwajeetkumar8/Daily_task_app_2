import 'package:daily_task_app/dashboard/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/auth_gate.dart';

void main() async{
  await Supabase.initialize(
      url: "https://xpxfhorkjvwlmirpawcg.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhweGZob3JranZ3bG1pcnBhd2NnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUxMjQ3NjcsImV4cCI6MjA2MDcwMDc2N30.ZzNQNL8NXtvyp8PJ2E2YNeWCTNPNbzDlTdkzQ_cqPz0");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:AuthGate(),
    );
  }
}
