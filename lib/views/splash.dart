import 'package:covidata_web/views/home_view.dart';
import 'package:covidata_web/utils/theme.dart';
import 'package:covidata_web/utils/theme_notifier.dart';
import 'package:covidata_web/views/home_view_desktop.dart';
import 'package:flutter/material.dart';
import 'package:covidata_web/utils/data.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Data data = Data();

  bool _darkMode;

  final List<Widget> _widgets = [
    Hero(
        tag: 'covidata',
        child: Text('CoviData',
            style: TextStyle(fontFamily: 'Megrim', fontSize: 42.0)))
  ];

  @override
  void initState() {
    Future.delayed(
        Duration(milliseconds: 1500),
            () => setState(() => _widgets.add(Text('India',
            style: TextStyle(
                fontFamily: 'Darker Grotesque',
                fontSize: 18.0)))));
    Future.delayed(
        Duration(milliseconds: 3000),
            () => setState(() => _widgets.add(Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ))));
    Future.delayed(
        Duration(milliseconds: 3000),
            () => data.getData().whenComplete(() => Navigator.of(context)
            .pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeViewDesktop()))));
    super.initState();
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widgets,
        ));
  }
}
