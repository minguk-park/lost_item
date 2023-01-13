import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  //bookmark
  isBookMark() {}

  initBookMark() async {
    const storage = FlutterSecureStorage();
    List<String> emptyList = [];
    await storage.write(key: 'bookmark', value: jsonEncode(emptyList));
  }

  createBookMark() async {
    const storage = FlutterSecureStorage();
    String? stringOfItems = await storage.read(key: 'bookmark');
    List<dynamic> listOfItems = jsonDecode(stringOfItems!);
  }

  createItemInfo(int categoryCode, String itemGrade, String itemName) {
    Map<String, dynamic> itemsInfo = {
      "categoryCode": categoryCode,
      "itemGrade": itemGrade,
      "itemName": itemName,
    };
    print(itemsInfo);
  }
}
