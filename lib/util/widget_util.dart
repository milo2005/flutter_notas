import 'dart:ui';
import 'package:flutter/material.dart';

void onDidWidgetLoaded(Function callback){
  WidgetsBinding.instance.addPostFrameCallback((d){
    callback();
  });
}