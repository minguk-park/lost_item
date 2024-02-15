import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:lost_item/function/functions.dart';

defaultSelectDialog(List list, Function function, context) {
  return Get.dialog(
    Dialog(
      child: Column(
        children: List.generate(
          list.length,
          (index) => InkWell(
            onTap: () {
              function(index);
              Navigator.of(context).pop();
            },
            child: Container(
              child: Text(list[index]),
            ),
          ),
        ),
      ),
    ),
  );
}
