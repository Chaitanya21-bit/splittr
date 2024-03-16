import 'package:flutter/material.dart';

extension RouteX on Route? {
  String toJson() {
    return {
      'name': this?.settings.name.toString(),
      'args': this?.settings.arguments.toString(),
    }.toString();
  }
}
