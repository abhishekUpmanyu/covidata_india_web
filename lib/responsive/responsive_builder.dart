import 'package:covidata_web/responsive/sizing_information.dart';
import 'package:covidata_web/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          var sizingInformation = SizingInformation(
              screenType: getDeviceType(mediaQuery),
              screenSize: mediaQuery.size,
            localWidgetSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight)
          );
      return builder(context, sizingInformation);
    });
  }
}
