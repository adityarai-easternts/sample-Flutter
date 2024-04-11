import 'package:flutter/material.dart';

enum Flavor { prod, dev }

class AppConfig {
  static Flavor? appFlavor;

  static String get appName {
    switch (appFlavor) {
      case Flavor.prod:
        return "Prod flavor challaaa";
      case Flavor.dev:
        return "UAT flavor challlaa";
      case null:
        return "Some error with flavors";
    }
  }

  static MaterialColor get primaryColor {
    switch (appFlavor) {
      case Flavor.prod:
        return Colors.blue;
      case Flavor.dev:
        return Colors.yellow;
      case null:
        return Colors.red;
    }
  }
}
