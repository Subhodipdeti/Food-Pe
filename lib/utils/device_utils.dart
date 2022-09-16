import 'package:flutter/material.dart';

/// Helper class for device related operations.
class DeviceUtils {
  // hides the keyboard if its already open
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// accepts a double [scale] and returns scaled sized based on the screen
  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  /// accepts a double [scale] and returns scaled sized based on the screen
  static double getScaledWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// accepts a double [scale] and returns scaled sized based on the screen
  static double getScaledHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
