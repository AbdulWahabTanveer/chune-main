import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget myResponsiveBuilder(context, child) {
  final resp = ResponsiveWrapper.builder(
      ClampingScrollWrapper.builder(context, child),
      breakpoints: const [
        ResponsiveBreakpoint.resize(480, name: MOBILE),
        ResponsiveBreakpoint.resize(768, name: TABLET),
        ResponsiveBreakpoint.resize(1024, name: DESKTOP),
        ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
      ]);

  return DevicePreview.appBuilder(context, resp);
}

bool largerThan(BuildContext context, {String layout}) {
  return ResponsiveWrapper.of(context).isLargerThan(layout);
}

bool smallerThan(BuildContext context, {String layout}) {
  return ResponsiveWrapper.of(context).isSmallerThan(layout);
}
