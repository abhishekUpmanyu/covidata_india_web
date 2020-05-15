import 'package:covidata_web/emuns/screen_type.dart';
import 'package:flutter/cupertino.dart';

class SizingInformation {
  final ScreenType screenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
      this.screenType,
      this.screenSize,
      this.localWidgetSize});

  @override
  String toString() {
    return 'DeviceType:$screenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
