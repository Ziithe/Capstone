import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context) {
  debugPrint('Height = ' + screenSize(context).height.toString());
  return screenSize(context).height;
}

double screenWidth(BuildContext context) {
  debugPrint('Width = ' + screenSize(context).width.toString());
  return screenSize(context).width;
}
