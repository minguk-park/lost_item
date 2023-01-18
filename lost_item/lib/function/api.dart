import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lost_item/models/marketsModels/marketsSearch/searchResult.dart';
import 'package:lost_item/models/marketsModels/marketsSearch/searchResultItems.dart';
import 'package:lost_item/secret.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/marketsModels/marketsOption/markets.dart';

class Api extends GetxController {
  late Markets marketOptions;
  Rx<SearchResult?> searchResult = null.obs;
  TextEditingController searchController = TextEditingController();
  final ScrollController itemsListScrollController = ScrollController();

  Map<String, dynamic> itemsCode = <String, dynamic>{};
  List itemsCodeName = [];
  var requestPerCategory = 3;
  var itemsPageSize = 10;

  //init
  var searchWord = '';
  var itemsList = [].obs;
  var itemsTotalCount = 0;
  var totalPageNo = 0;
  var curPage = 1.obs;

  var selectCodeName = "강화 재료".obs;
  var selectCode = 0.obs; //default = 강화 재료

  @override
  void onInit() {
    super.onInit();
    itemsListScrollEvent();
  }

  void itemsListScrollEvent() {
    itemsListScrollController.addListener(() async {
      if (itemsListScrollController.position.pixels ==
          itemsListScrollController.position.maxScrollExtent) {
        await postMarketsSearchPagenation();
      }
    });
  }

  initValue() {
    searchWord = '';
    itemsList.value = [];
    itemsTotalCount = 0;
    totalPageNo = 0;
    curPage.value = 1;

    update();
  }

  Future<void> getMarketsOption() async {
    var headers = {
      'Accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
    };

    var request = http.Request(
      'GET',
      Uri.parse(Env.marketOptions),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      itemsCode.clear();
      itemsCodeName.clear();
      var responseData = await response.stream.bytesToString();
      var marketOptionsMap = jsonDecode(responseData);
      marketOptions = Markets.fromJson(marketOptionsMap);

      marketOptions.categories?.forEach((element) {
        itemsCode.addEntries({element.codeName!: element.code}.entries);
        itemsCodeName.add(element.codeName!);
      });

      selectCode.value = itemsCode[selectCodeName];

      // print(itemsCode);
      // print(itemsCodeName);
    } else {
      // print(response.reasonPhrase);
      switch (response.statusCode) {
        case 401:
        // Fluttertoast.showToast(msg: '잘못된 회원정보입니다. 다시 로그인해주세요.');
        // final authController = Get.put(AuthGetX());
        // authController.authClear();
        // break;
        default:
          print('getMarketsOption: 알 수 없는 오류');
          break;
      }
    }
  }

// post body
// {
//   "Sort": "GRADE",
//   "CategoryCode": 0,           필수
//   "CharacterClass": "string",
//   "ItemTier": 0,
//   "ItemGrade": "string",
//   "ItemName": "string",
//   "PageNo": 0,
//   "SortCondition": "ASC"
// }
  Future<void> postMarketsSearch(
      String search, int categoryCode, String itemGrade) async {
    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(Env.marketSearch),
      headers: headers,
      body: json.encode({
        "CategoryCode": categoryCode,
        "ItemName": search,
        "ItemGrade": itemGrade,
      }),
    );

    if (response.statusCode == 200) {
      initValue();

      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;

      itemsTotalCount = searchResult.value?.totalCount ?? 0;
      if (itemsTotalCount != 0) {
        totalPageNo = itemsTotalCount ~/ itemsPageSize;
        if (itemsTotalCount % itemsPageSize != 0) {
          totalPageNo = totalPageNo + 1;
        }
      }
      searchResult.value?.items?.forEach((element) {
        itemsList.add(element);
      });
      searchWord = search;

      // print(itemsList[0].name);

      update();
    } else {
      print(response.statusCode);
      switch (response.statusCode) {
        case 401:
        // Fluttertoast.showToast(msg: '잘못된 회원정보입니다. 다시 로그인해주세요.');
        // final authController = Get.put(AuthGetX());
        // authController.authClear();
        // break;
        default:
          print('postMarketsSearch: 알 수 없는 오류');
          break;
      }
    }
  }

  Future<void> postMarketsSearchPagenation() async {
    if (totalPageNo < curPage.value) return;
    curPage = curPage + 1;
    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer ${Secret.devApiKey}',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      Uri.parse(Env.marketSearch),
      headers: headers,
      body: json.encode({
        "CategoryCode": selectCode.value,
        "ItemName": searchWord,
        "PageNo": curPage.value,
      }),
    );

    if (response.statusCode == 200) {
      var searchResultMap = jsonDecode(response.body);
      searchResult = SearchResult.fromJson(searchResultMap).obs;

      // if (itemsTotalCount > requestPerCategory) {
      //   itemsTotalCount = requestPerCategory;
      // }
      searchResult.value?.items?.forEach((element) {
        itemsList.add(element);
      });

      update();
    } else {
      print(response.statusCode);
      switch (response.statusCode) {
        case 401:
        // Fluttertoast.showToast(msg: '잘못된 회원정보입니다. 다시 로그인해주세요.');
        // final authController = Get.put(AuthGetX());
        // authController.authClear();
        // break;
        default:
          print('postMarketsSearch: 알 수 없는 오류');
          break;
      }
    }
  }

  void allItemSearch(String saerch) {}

  void getAuctionsOption() {}
}
