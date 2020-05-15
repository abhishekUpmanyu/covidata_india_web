import 'package:covidata_web/emuns/screen_type.dart';
import 'package:covidata_web/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({Key key, this.mobile, this.tablet, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.screenType == ScreenType.tablet) {
          if (tablet != null) {
            return tablet;
          }
        }

        if (sizingInformation.screenType == ScreenType.desktop) {
          if (desktop != null) {
            return desktop;
          }
        }

        return mobile;
      },
    );
  }
}
