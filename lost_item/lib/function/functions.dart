import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  initBookMark() async {
    const storage = FlutterSecureStorage();
    List<String> emptyList = [];
    await storage.write(key: 'bookmark', value: jsonEncode(emptyList));
  }

  isBookMark(Map bookmarkInfo) async {
    const storage = FlutterSecureStorage();
    String? stringOfItems = await storage.read(key: 'bookmark');
    if (stringOfItems == null) {
      initBookMark();
      stringOfItems = await storage.read(key: 'bookmark');
    }
    List<dynamic> listOfItems = jsonDecode(stringOfItems!);

    for (var element in listOfItems) {
      if (mapEquals(element, bookmarkInfo)) return true;
    }

    return false;
  }

  createBookMark(Map createdBookmarkInfo) async {
    const storage = FlutterSecureStorage();
    String? stringOfItems = await storage.read(key: 'bookmark');
    if (stringOfItems == null) {
      initBookMark();
      stringOfItems = await storage.read(key: 'bookmark');
    }
    List<dynamic> listOfItems = jsonDecode(stringOfItems!);

    await storage.write(key: 'bookmark', value: jsonEncode(listOfItems));

    print(listOfItems);
  }

  deleteBookmark(Map bookmarkInfo) async {
    const storage = FlutterSecureStorage();
    String? stringOfItems = await storage.read(key: 'bookmark');
    if (stringOfItems == null) {
      initBookMark();
      stringOfItems = await storage.read(key: 'bookmark');
    }
    List<dynamic> listOfItems = jsonDecode(stringOfItems!);

    for (var element in listOfItems) {
      if (mapEquals(element, bookmarkInfo)) {
        listOfItems.remove(element);
        break;
      }
    }

    await storage.write(key: 'bookmark', value: jsonEncode(listOfItems));

    print(listOfItems);
  }

  createItemInfo(int categoryCode, String itemGrade, String itemName) {
    Map<String, dynamic> itemsInfo = {
      "categoryCode": categoryCode,
      "itemGrade": itemGrade,
      "itemName": itemName,
    };

    return itemsInfo;
  }
}
