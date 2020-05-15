import 'package:covidata_web/views/about_view_desktop.dart';
import 'package:covidata_web/views/home_view_desktop.dart';
import 'package:covidata_web/widgets/app_bar_desktop_tile.dart';
import 'package:flutter/material.dart';

class AppBarDesktop extends StatefulWidget {
  @override
  _AppBarDesktopState createState() => _AppBarDesktopState();
}

class _AppBarDesktopState extends State<AppBarDesktop> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/covidata-logo.png', width: 50.0),
          ),
          AppBarDesktopTile(
              expanded: _expanded,
              icon: Icons.home,
              text: 'Home',
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeViewDesktop()))),
          AppBarDesktopTile(
              expanded: _expanded,
              icon: Icons.info,
              text: 'About',
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => AboutViewDesktop()))),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBarDesktopTile(
                  expanded: _expanded,
                  icon: _expanded ? Icons.chevron_left : Icons.chevron_right,
                  text: 'Less',
                  onPressed: () => setState(() => _expanded = !_expanded)),
            ],
          ))
        ],
      ),
    );
  }
}
