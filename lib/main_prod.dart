import 'package:flutter/material.dart';
import 'package:namer_app/app_config.dart';
import 'package:namer_app/main_common.dart';

void main() {
  debugPrint("mainprod runnninnn");
  AppConfig.appFlavor = Flavor.prod;
  mainCommon();
}

