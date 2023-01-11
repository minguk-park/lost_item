import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lost_item/function/api.dart';

class Functions extends GetxController {
  //select dialog
  selectDialog(index) {
    final api = Get.put(Api());
    api.initValue();
    String selectName = api.itemsCodeName[index];
    api.selectCodeName.value = selectName;
    api.selectCode.value = api.itemsCode[selectName];
    return;
  }
}
