import 'package:flutter/material.dart';
import 'package:get/get.dart';

defaultSelectDialog(){
  return Get.dialog(
    Dialog(
      child: Container(
        height: 500,
        child: const Center(child: Text('Dialog')),
      ),
    ),
  );
}