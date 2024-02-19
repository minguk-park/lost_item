import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BookMark extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<dynamic> bookMarkList = [].obs;

  initBookMark(storage) async {
    String? stringOfItems = await storage.read(key: 'bookmark');
    if (stringOfItems == null) {
      const storage = FlutterSecureStorage();
      List<String> emptyList = [];
      await storage.write(key: 'bookmark', value: jsonEncode(emptyList));
      stringOfItems = await storage.read(key: 'bookmark');
    }
    // List<dynamic> listOfItems = jsonDecode(stringOfItems!);
    return jsonDecode(stringOfItems!);
  }

  takeBookMark() async {
    print('takeBookMark');
    const storage = FlutterSecureStorage();

    List<dynamic> listOfItems = await initBookMark(storage);
    bookMarkList.clear();
    listOfItems.forEach((element) {
      bookMarkList.add(element.toString());
    });

    print(bookMarkList);
  }

  Future<bool> isBookMark(Map bookmarkInfo) async {
    const storage = FlutterSecureStorage();

    List<dynamic> listOfItems = await initBookMark(storage);
    for (var element in listOfItems) {
      if (mapEquals(element, bookmarkInfo)) return true;
    }

    return false;
  }

  createBookMark(Map createdBookmarkInfo) async {
    print('createBookMark');

    const storage = FlutterSecureStorage();
    List<dynamic> listOfItems = await initBookMark(storage);
    listOfItems.add(createdBookmarkInfo);
    bookMarkList.add(createdBookmarkInfo.toString());

    // print(jsonEncode(listOfItems));

    await storage.write(key: 'bookmark', value: jsonEncode(listOfItems));
    update();
  }

  deleteBookmark(Map bookmarkInfo) async {
    print('deleteBookmark');

    const storage = FlutterSecureStorage();
    List<dynamic> listOfItems = await initBookMark(storage);
    for (var element in listOfItems) {
      if (mapEquals(element, bookmarkInfo)) {
        listOfItems.remove(element);
        bookMarkList.remove(bookmarkInfo.toString());
        update();
        break;
      }
    }

    // print(jsonEncode(listOfItems));

    await storage.write(key: 'bookmark', value: jsonEncode(listOfItems));
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
