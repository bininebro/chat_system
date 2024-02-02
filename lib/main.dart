import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import 'chat_system.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff0E0D0D),
        appBarTheme: const AppBarTheme(color: Color(0xff0E0D0D)),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}
