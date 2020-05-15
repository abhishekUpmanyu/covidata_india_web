import 'package:covidata_web/utils/theme.dart';
import 'package:covidata_web/utils/theme_notifier.dart';
import 'package:covidata_web/views/home_view.dart';
import 'package:covidata_web/views/splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier(darkTheme),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeNotifier.getTheme(),
      title: 'CoviData India',
      home: Splash(),
    );
  }
}