import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BookMark extends GetxController {
  
  static const storage = FlutterSecureStorage();
  List<dynamic> listOfItems = [].obs;

  RxList bookMarkItemsId = [].obs;

  @override
  Future<void> onInit() async {
    listOfItems = await initBookMark();
    super.onInit();
  }

  initBookMark() async {
    String? stringOfItems = await storage.read(key: 'bookmark');
    if (stringOfItems == null) {
      List<String> emptyList = [];
      await storage.write(key: 'bookmark', value: jsonEncode(emptyList));
      stringOfItems = await storage.read(key: 'bookmark');
    }
    // List<dynamic> listOfItems = jsonDecode(stringOfItems!);
    return jsonDecode(stringOfItems!);
  }

  takeBookMark() async {
    print('takeBookMark');
    bookMarkItemsId.clear();
    for (var element in listOfItems) {
      bookMarkItemsId.add(element['itemCode']);
    }
    
    print(listOfItems);
    print(bookMarkItemsId);
  }

  Future<bool> isBookMark(Map bookmarkInfo) async {
    for (var element in listOfItems) {
      if (mapEquals(element, bookmarkInfo)) return true;
    }

    return false;
  }

  createBookMark(Map createdBookmarkInfo) async {
    print('createBookMark');

    listOfItems.add(createdBookmarkInfo);
    bookMarkItemsId.add(createdBookmarkInfo['itemCode']);


    print(listOfItems);
    print(bookMarkItemsId);

    await storage.write(key: 'bookmark', value: jsonEncode(listOfItems));
    update();
  }

  deleteBookmark(Map bookmarkInfo) async {
    print('deleteBookmark');

    for (var element in listOfItems) {
      if (mapEquals(element, bookmarkInfo)) {
        listOfItems.remove(element);
        bookMarkItemsId.remove(bookmarkInfo['itemCode']);
        update();
        break;
      }
    }

    print(listOfItems);
    print(bookMarkItemsId);

    await storage.write(key: 'bookmark', value: jsonEncode(listOfItems));
  }

  refreshBookMark() async{

  }

  createItemInfo(int categoryCode, int itemCode, String itemGrade, String itemName) {
    Map<String, dynamic> itemsInfo = {
      "categoryCode": categoryCode,
      "itemCode" : itemCode,
      "itemGrade": itemGrade,
      "itemName": itemName,
    };
    return itemsInfo;
  }
}
