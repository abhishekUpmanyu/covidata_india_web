import 'package:flutter/material.dart';

class AppBarDesktopTile extends StatelessWidget {
  final bool expanded;
  final IconData icon;
  final VoidCallback onPressed;
  final String text;

  const AppBarDesktopTile(
      {Key key, this.expanded, this.icon, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded
        ? SizedBox(
      width: 200,
          child: ListTile(
              leading: Icon(icon),
              title: Text(text),
              onTap: onPressed,
            ),
        )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(icon), onPressed: onPressed),
        );
  }
}
