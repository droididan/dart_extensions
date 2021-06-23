import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveTools {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  static late Orientation orientation;

  static late DeviceType deviceType;

  static late double h;

  static late double w;

  static void setAppSize(BoxConstraints constraints, Orientation currentOrientation) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Sets screen width and height
    if (orientation == Orientation.portrait) {
      w = boxConstraints.maxWidth;
      h = boxConstraints.maxHeight;
    } else {
      w = boxConstraints.maxHeight;
      h = boxConstraints.maxWidth;
    }

    // Sets ScreenType
    if (kIsWeb) {
      deviceType = DeviceType.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      if ((orientation == Orientation.portrait && w < 600) || (orientation == Orientation.landscape && h < 600)) {
        deviceType = DeviceType.mobile;
      } else {
        deviceType = DeviceType.tablet;
      }
    } else if (Platform.isMacOS) {
      deviceType = DeviceType.mac;
    } else if (Platform.isWindows) {
      deviceType = DeviceType.windows;
    } else if (Platform.isLinux) {
      deviceType = DeviceType.linux;
    } else {
      deviceType = DeviceType.fuchsia;
    }
  }
}

enum DeviceType { mobile, tablet, web, mac, windows, linux, fuchsia }

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({Key? key, required this.builder}) : super(key: key);
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ResponsiveTools.setAppSize(constraints, orientation);
        return builder(context, orientation, ResponsiveTools.deviceType);
      });
    });
  }
}

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

extension SizerExt on num {
  double get hResponsive => this * ResponsiveTools.h / 100;
  double get wResponsive => this * ResponsiveTools.w / 100;
  double get textSizeResponsive => this * (ResponsiveTools.w / 3) / 100;
}
