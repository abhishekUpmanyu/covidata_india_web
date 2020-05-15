import 'package:covidata_web/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        body: Center(
          child: Text(sizingInformation.toString()),
        ),
      ),
    );
  }
}
